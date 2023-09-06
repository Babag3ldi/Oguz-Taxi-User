import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import '../models/search_model.dart';
import '../provider/tarif_provider.dart';
import '../searches/location_search_delegate.dart';
import '../widgets/drawer.dart';

class MainExample extends StatefulWidget {
  const MainExample({Key? key}) : super(key: key);

  @override
  _MainExampleState createState() => _MainExampleState();
}

class _MainExampleState extends State<MainExample> with OSMMixinObserver {
  late MapController controller;
  late GlobalKey<ScaffoldState> scaffoldKey;
  Key mapGlobalkey = UniqueKey();
  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
  ValueNotifier<bool> advPickerNotifierActivation = ValueNotifier(false);
  ValueNotifier<double> positionOSMLayers = ValueNotifier(-200);
  ValueNotifier<GeoPoint?> centerMap = ValueNotifier(null);
  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);
  ValueNotifier<bool> showFab = ValueNotifier(true);
  ValueNotifier<bool> tarifSaylandy = ValueNotifier(false);
  ValueNotifier<int> tarif = ValueNotifier(1);
  ValueNotifier<GeoPoint?> lastGeoPoint = ValueNotifier(null);
  ValueNotifier<bool> beginDrawRoad = ValueNotifier(false);
  ValueNotifier<bool> zakazEdildi = ValueNotifier(false);
  List<GeoPoint> pointsRoad = [];
  Timer? timer;
  int x = 0;
  final OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf62487a5ed48035e0422f9b50b150f64edf2f');
  double startLat = 37.95427597018044;
  double startLng = 58.373661547266835;
  double endLat = 38.00676416185372;
  double endLng = 58.28377671640675;
  SearchResult? myLocationResult;
  SearchResult? firstLocationResult;
  SearchResult? secondLocationResult;
  List<ORSCoordinate> routeCoordinate = [];
  @override
  void initState() {
    super.initState();

    _getCurrentPosition();
    controller = MapController.customLayer(
      initMapWithUserPosition:
          true, //UserTrackingOption(enableTracking: false, unFollowUser: true),
      areaLimit: BoundingBox(
        east: 37.966667,
        north: 37.733333,
        south: 37.966667,
        west: 37.733333,
      ),
      customTile: CustomTile(
        sourceName: "openstreetmap",
        tileExtension: ".png",
        minZoomLevel: 10,
        maxZoomLevel: 19,
        urlsServers: [TileURLs(url: "https://a.tile.openstreetmap.org/")],
        tileSize: 256,
      ),
    );
    controller.addObserver(this);
    scaffoldKey = GlobalKey<ScaffoldState>();

    fetchRoute();
  }

  showBottomm(double distance) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              children: [
                Text(
                  "Aralyk: $distance km",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Bahasy: ${(distance * 1.5).ceilToDouble()} manat",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          );
        });
  }

  Widget aralykBaha(double d) {
    double distance = (d / 1000).ceilToDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 40),
          child: Divider(),
        ),
        Text(
          "Aralyk: $distance km",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Roboto'),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Bahasy: ${(distance * 1.5).ceilToDouble()} manat",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Roboto'),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 40),
          child: Divider(),
        ),
      ],
    );
  }

  List<GeoPoint> croad = [];
  fetchRoute() async {
    routeCoordinate = await client.directionsRouteCoordsGet(
      profileOverride: ORSProfile.drivingCar,
      startCoordinate: ORSCoordinate(latitude: startLat, longitude: startLng),
      endCoordinate: ORSCoordinate(latitude: endLat, longitude: endLng),
    );
  }

  Future<void> mapIsInitialized() async {
    await controller.setZoom(zoomLevel: 12);
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await mapIsInitialized();
    }
  }

  @override
  void onRoadTap(RoadInfo road) {
    super.onRoadTap(road);
    debugPrint("road:$road");
    Future.microtask(() => controller.removeRoad(roadKey: road.key));
  }

  @override
  void dispose() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  ORSCoordinate? latLng;
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        latLng = ORSCoordinate(
            latitude: _currentPosition!.latitude,
            longitude: _currentPosition!.longitude);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  TextEditingController myLocationText = TextEditingController();
  TextEditingController firstLocationText = TextEditingController();
  TextEditingController secondLocationText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TarifProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: const Drawer1(),
      body: Stack(
        children: [
          OSMFlutter(
            controller: controller,
            mapIsLoading: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Karta ýüklenýär.."),
                ],
              ),
            ),
            onMapIsReady: (isReady) {
              if (isReady) {
                // print("map is ready");
              }
            },

            // userLocationMarker: UserLocationMaker(
            //     personMarker: MarkerIcon(
            //       // icon: Icon(
            //       //   Icons.car_crash_sharp,
            //       //   color: Colors.red,
            //       //   size: 48,
            //       // ),
            //       iconWidget: SizedBox.square(
            //         dimension: 32,
            //         child: Image.asset(
            //           "assets/Shape.png",
            //           scale: .2,
            //         ),
            //       ),
            //       /* assetMarker: AssetMarker(
            //       image: AssetImage(
            //         "assets/taxi.png",
            //       ),
            //       scaleAssetImage: 0.3,
            //     ), */
            //     ),
            //     directionArrowMarker: const MarkerIcon(
            //       icon: Icon(
            //         Icons.navigation_rounded,
            //         size: 48,
            //       ),
            //     )
            //     // directionArrowMarker: MarkerIcon(
            //     //   assetMarker: AssetMarker(
            //     //     image: AssetImage(
            //     //       "assets/taxi.png",
            //     //     ),
            //     //     scaleAssetImage: 0.25,
            //     //   ),
            //     // ),
            //     ),

            onLocationChanged: (myLocation) {
              print(myLocation);
            },
            onGeoPointClicked: (geoPoint) async {
              if (geoPoint ==
                  GeoPoint(
                    latitude: 47.442475,
                    longitude: 8.4680389,
                  )) {
                final newGeoPoint = GeoPoint(
                  latitude: 47.4517782,
                  longitude: 8.4716146,
                );
                await controller.changeLocationMarker(
                  oldLocation: geoPoint,
                  newLocation: newGeoPoint,
                  markerIcon: const MarkerIcon(
                    icon: Icon(
                      Icons.bus_alert,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                );
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    geoPoint.toMap().toString(),
                  ),
                  action: SnackBarAction(
                    onPressed: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    label: "hide",
                  ),
                ),
              );
            },

            // osmOption:  OSMOption(enableRotationByGesture: true),
          ),
          // position bellemek ucn
          Positioned(
            bottom: 360,
            left: 10,
            child: ValueListenableBuilder<bool>(
              valueListenable: advPickerNotifierActivation,
              builder: (ctx, visible, child) {
                return Visibility(
                  visible: visible,
                  child: AnimatedOpacity(
                    opacity: visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: child,
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: FloatingActionButton(
                  key: UniqueKey(),
                  heroTag: "confirmAdvPicker",
                  isExtended: true,
                  onPressed: () async {
                    advPickerNotifierActivation.value = false;
                    GeoPoint p =
                        await controller.selectAdvancedPositionPicker();

                    GeoJsonFeatureCollection gg =
                        await client.geocodeReverseGet(
                      point: ORSCoordinate(
                        latitude: p.latitude,
                        longitude: p.longitude,
                      ),
                      size: 1,
                      boundaryCountry: 'TM',
                    );
                    Properties prop =
                        Properties.fromJson(gg.features[0].properties);
                    myLocationText.text = prop.name;
                    // print(p);
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
          //oz location gaytya
          Positioned(
            bottom: 10,
            left: 10,
            child: ValueListenableBuilder<bool>(
              valueListenable: visibilityZoomNotifierActivation,
              builder: (ctx, visibility, child) {
                return Visibility(
                  visible: visibility,
                  child: child!,
                );
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: zoomNotifierActivation,
                builder: (ctx, isVisible, child) {
                  return AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    onEnd: () {
                      visibilityZoomNotifierActivation.value = isVisible;
                    },
                    duration: const Duration(milliseconds: 500),
                    child: child,
                  );
                },
                child: Column(
                  children: [
                    ElevatedButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        controller.zoomIn();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      child: const Icon(Icons.remove),
                      onPressed: () async {
                        controller.zoomOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              height: 200,
              color: Colors.black,
            ),
          ),
          Positioned(
            left: 10,
            top: 20,
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState!.openDrawer(),
            ),
          ),
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PointerInterceptor(
        child: Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            onPressed: () async {
              // await _getCurrentPosition();
              controller.changeLocation(GeoPoint(
                  latitude: latLng!.latitude, longitude: latLng!.longitude));
              for (int i = 1; i < 6; i++) {
                controller.zoomIn();
              }
              // if (!trackingNotifier.value) {
              //   await controller.currentLocation();
              //   await controller.enableTracking(
              //     enableStopFollow: true,
              //     disableUserMarkerRotation: true,
              //   );
              //   //await controller.zoom(5.0);
              // } else {
              //   await controller.disabledTracking();
              // }
              // trackingNotifier.value = !trackingNotifier.value;
            },
            child: const Icon(Icons.my_location),
            // ValueListenableBuilder<bool>(
            //   valueListenable: trackingNotifier,
            //   builder: (ctx, isTracking, _) {
            //     if (isTracking) {
            //       return const Icon(Icons.gps_off_sharp);
            //     }
            //     return const Icon(Icons.my_location);
            //   },
            // ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: ValueListenableBuilder<bool>(
              valueListenable: tarifSaylandy,
              builder: (ctx, isApproved, _) {
                return isApproved
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          myLocationResult != null
                              ? Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await gotoMyLocation();
                                        },
                                        icon: const Icon(
                                            Icons.location_on_outlined)),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.4,
                                        child: Text(
                                          myLocationResult!.name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          myLocationResult = null;
                                        },
                                        icon: const Icon(Icons.close)),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, right: 15, top: 20),
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: TextFormField(
                                          maxLines: 1,
                                          controller: myLocationText,
                                          //  style: TextStyle(fontSize: 12),
                                          decoration: const InputDecoration(
                                            hintText: "Meniň salgym",
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3))),
                                          ),
                                          onTap: () async {
                                            final result = await showSearch(
                                                context: context,
                                                delegate:
                                                    LocationSearchDelegate());
                                            //controller.
                                            try {
                                              SearchResult s =
                                                  result as SearchResult;
                                              myLocationText.text = s.name;
                                              myLocationResult = s;
                                              // print(s.coordinates);
                                              await gotoMyLocation();

                                              await controller.changeLocation(
                                                  GeoPoint(
                                                      latitude: s
                                                          .coordinates.latitude,
                                                      longitude: s.coordinates
                                                          .longitude));
                                            } catch (e) {}
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: IconButton(
                                          onPressed: () async {
                                            if (advPickerNotifierActivation
                                                    .value ==
                                                false) {
                                              advPickerNotifierActivation
                                                  .value = true;
                                              await controller
                                                  .advancedPositionPicker();
                                            }
                                          },
                                          icon: Icon(
                                            advPickerNotifierActivation.value ==
                                                    false
                                                ? Icons.map
                                                : Icons.check_circle,
                                            size: 40,
                                          )),
                                    )
                                  ],
                                ),
                          firstLocationResult != null
                              ? Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await gotoFirstLocation();
                                        },
                                        icon: const Icon(
                                            Icons.location_on_outlined)),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.4,
                                        child: Text(
                                          firstLocationResult!.name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          firstLocationResult = null;
                                        },
                                        icon: const Icon(Icons.close)),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, right: 15, top: 20),
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      height: 50,
                                      child: TextFormField(
                                          controller: firstLocationText,
                                          decoration: const InputDecoration(
                                            hintText: "Barmaly salgym",
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3))),
                                          ),
                                          onTap: () async {
                                            final result = await showSearch(
                                                context: context,
                                                delegate:
                                                    LocationSearchDelegate());
                                            //controller.
                                            try {
                                              SearchResult s =
                                                  result as SearchResult;
                                              firstLocationText.text = s.name;
                                              firstLocationResult = s;
                                              await gotoFirstLocation();
                                              await controller.changeLocation(
                                                  GeoPoint(
                                                      latitude: s
                                                          .coordinates.latitude,
                                                      longitude: s.coordinates
                                                          .longitude));
                                            } catch (e) {}
                                          }),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          if (advPickerNotifierActivation
                                                  .value ==
                                              false) {
                                            advPickerNotifierActivation.value =
                                                true;
                                            await controller
                                                .advancedPositionPicker();
                                          }
                                        },
                                        icon: Icon(
                                          advPickerNotifierActivation.value ==
                                                  false
                                              ? Icons.map
                                              : Icons.check_circle,
                                          size: 40,
                                        ))
                                  ],
                                ),
                          if (myLocationResult != null &&
                              firstLocationResult != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, top: 10, bottom: 10),
                              child: aralykBaha(Geolocator.distanceBetween(
                                  myLocationResult!.g.latitude,
                                  myLocationResult!.g.longitude,
                                  firstLocationResult!.g.latitude,
                                  firstLocationResult!.g.longitude)),
                            ),
                          ValueListenableBuilder<bool>(
                              valueListenable: zakazEdildi,
                              builder: (ctx, isApproved, _) {
                                return isApproved
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.2,
                                                child:
                                                    const LinearProgressIndicator()),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Center(
                                                child: Text("Garaşylýar")),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          minimumSize: Size(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.2,
                                                              45),
                                                          maximumSize: Size(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.2,
                                                              45)),
                                                  onPressed: () {
                                                    zakazEdildi.value = false;

                                                    controller.clearAllRoads();
                                                    setState(() {
                                                      myLocationResult = null;
                                                      firstLocationResult =
                                                          null;
                                                      myLocationText.clear();
                                                      firstLocationText.clear();
                                                    });
                                                    // drawTaxiRoad();
                                                  },
                                                  child: const Text(
                                                    "Sargydy ýatyrmak",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF4C5BFF),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                minimumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        1.2,
                                                    45),
                                                maximumSize: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        1.2,
                                                    45)),
                                            onPressed: () {
                                              if (myLocationResult != null &&
                                                  firstLocationResult != null) {
                                                drawTaxiRoad();
                                                zakazEdildi.value = true;
                                              }
                                            },
                                            child: const Text(
                                              "Sargyt etmek",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            )),
                                      );
                              }),
                        ],
                      )
                    : ListView(
                        children: [
                          // const SizedBox(
                          //   height: 50,
                          // ),
                          const Padding(
                              padding: EdgeInsets.only(left: 40, top: 10),
                              child: ListTile(
                                  // titleAlignment: ListTileTitleAlignment.center,
                                  title: Text(
                                      "Aşakdaky tarifleriň birini saýlaň"))),
                          const Divider(),
                          ValueListenableBuilder<int>(
                              valueListenable: tarif,
                              builder: (ctx, index, _) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 0, right: 15),
                                      decoration: BoxDecoration(
                                          color: index == 0
                                              ? const Color(0xFFE5E7FF)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ListTile(
                                        leading: index == 0
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.black,
                                              )
                                            : null,
                                        title: Container(
                                            margin: index == 0
                                                ? null
                                                : const EdgeInsets.only(
                                                    left: 40),
                                            child: const Text("Sagatlaýyn")),
                                        onTap: () {
                                          tarif.value = 0;
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10, right: 15),
                                      decoration: BoxDecoration(
                                          color: index == 1
                                              ? const Color(0xFFE5E7FF)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ListTile(
                                        leading: index == 1
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.black,
                                              )
                                            : null,
                                        title: Container(
                                            margin: index == 1
                                                ? null
                                                : const EdgeInsets.only(
                                                    left: 40),
                                            child: const Text("Adaty")),
                                        onTap: () {
                                          tarif.value = 1;
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 15, top: 10, right: 15),
                                      decoration: BoxDecoration(
                                          color: index == 2
                                              ? const Color(0xFFE5E7FF)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ListTile(
                                        leading: index == 2
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.black,
                                              )
                                            : null,
                                        title: Container(
                                            margin: index == 2
                                                ? null
                                                : const EdgeInsets.only(
                                                    left: 40),
                                            child: const Text("Ýol ugruna")),
                                        onTap: () {
                                          tarif.value = 2;
                                          // Provider.of<TarifProvider>(context,
                                          //         listen: false)
                                          //     .setTarif(2);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4C5BFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width / 2,
                                        45),
                                    maximumSize: Size(
                                        MediaQuery.of(context).size.width / 1.2,
                                        45)),
                                onPressed: () {
                                  tarifSaylandy.value = true;
                                },
                                child: const Text(
                                  "Tassyklamak",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                )),
                          )
                        ],
                      );
              })),
    );
  }

  gotoMyLocation() async {
    controller.addMarker(myLocationResult!.g,
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 100,
            color: Colors.blue,
          ),
        ));
    if (myLocationResult!.box == null) {
      await controller.goToLocation(myLocationResult!.g);
      controller.setZoom(stepZoom: 10);
    } else {
      await controller.zoomToBoundingBox(myLocationResult!.box!,
          paddinInPixel: 50);
    }
  }

  gotoFirstLocation() async {
    controller.addMarker(firstLocationResult!.g,
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 100,
            color: Colors.blue,
          ),
        ));
    if (firstLocationResult!.box == null) {
      await controller.goToLocation(firstLocationResult!.g);
      controller.setZoom(stepZoom: 10);
    } else {
      await controller.zoomToBoundingBox(firstLocationResult!.box!,
          paddinInPixel: 50);
    }
  }

  void roadActionBt(BuildContext ctx) async {
    try {
      ///selection geoPoint

      showFab.value = false;
      ValueNotifier<RoadType> notifierRoadType = ValueNotifier(RoadType.car);

      final bottomPersistant = scaffoldKey.currentState!.showBottomSheet(
        (ctx) {
          return PointerInterceptor(child: const SizedBox());
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );
      await bottomPersistant.closed.then((roadType) async {
        showFab.value = true;
        beginDrawRoad.value = false;
        RoadInfo roadInformation = await controller.drawRoad(
          pointsRoad.first,
          pointsRoad.last,
          roadType: notifierRoadType.value,
          intersectPoint:
              pointsRoad.getRange(1, pointsRoad.length - 1).toList(),
          // roadOption: RoadOption(
          //   roadWidth: 15,
          //   roadColor: Colors.red,
          //   zoomInto: true,
          //   roadBorderWidth: 2,
          //   roadBorderColor: Colors.green,
          // ),
        );
        pointsRoad.clear();
        debugPrint(
            "app duration:${Duration(seconds: roadInformation.duration!.toInt()).inMinutes}");
        debugPrint("app distance:${roadInformation.distance}Km");
        debugPrint("app road:$roadInformation");
        final console = roadInformation.instructions
            .map((e) => e.toString())
            .reduce(
              (value, element) => "$value -> \n $element",
            )
            .toString();
        debugPrint(
          console,
          wrapWidth: console.length,
        );
        // final box = await BoundingBox.fromGeoPointsAsync([point2, point]);
        // controller.zoomToBoundingBox(
        //   box,
        //   paddinInPixel: 64,
        // );
      });
    } on RoadException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${e.errorMessage()}",
          ),
        ),
      );
    }
  }

  // @override
  // Future<void> mapRestored() async {
  //   super.mapRestored();
  //   // print("log map restored");
  // }

  void drawMultiRoads() async {
    /*
      8.4638911095,47.4834379430|8.5046595453,47.4046149269
      8.5244329867,47.4814981476|8.4129691189,47.3982152237
      8.4371175094,47.4519015578|8.5147623089,47.4321999727
     */

    final configs = [
      MultiRoadConfiguration(
        startPoint: GeoPoint(
          latitude: 47.4834379430,
          longitude: 8.4638911095,
        ),
        destinationPoint: GeoPoint(
          latitude: 47.4046149269,
          longitude: 8.5046595453,
        ),
      ),
      MultiRoadConfiguration(
          startPoint: GeoPoint(
            latitude: 47.4814981476,
            longitude: 8.5244329867,
          ),
          destinationPoint: GeoPoint(
            latitude: 47.3982152237,
            longitude: 8.4129691189,
          ),
          roadOptionConfiguration: const MultiRoadOption(
            roadColor: Colors.orange,
          )),
      MultiRoadConfiguration(
        startPoint: GeoPoint(
          latitude: 47.4519015578,
          longitude: 8.4371175094,
        ),
        destinationPoint: GeoPoint(
          latitude: 47.4321999727,
          longitude: 8.5147623089,
        ),
      ),
    ];
    final listRoadInfo = await controller.drawMultipleRoad(
      configs,
      commonRoadOption: const MultiRoadOption(
        roadColor: Colors.red,
      ),
    );
    print(listRoadInfo);
  }

  Future<void> drawRoadManually() async {
    List<GeoPoint> taxiyol = [];
    routeCoordinate = await client.directionsRouteCoordsGet(
      profileOverride: ORSProfile.drivingCar,
      startCoordinate: ORSCoordinate(latitude: startLat, longitude: startLng),
      endCoordinate: ORSCoordinate(latitude: endLat, longitude: endLng),
    );
    taxiyol = List<GeoPoint>.from(routeCoordinate
        .map((e) => GeoPoint(latitude: e.latitude, longitude: e.longitude)));
    print(
        "km=${Geolocator.distanceBetween(startLat, startLng, endLat, endLng)}");
    await controller.drawRoadManually(
      taxiyol,
      const RoadOption(
          zoomInto: true,
          roadColor: Colors.blueAccent,
          roadWidth: 10,
          roadBorderWidth: 15),
    );
  }

  drawTaxiRoad() async {
    List<GeoPoint> taxiyol = [];
    routeCoordinate = await client.directionsRouteCoordsGet(
      profileOverride: ORSProfile.drivingCar,
      startCoordinate: myLocationResult!.coordinates,
      endCoordinate: firstLocationResult!.coordinates,
    );
    taxiyol = List<GeoPoint>.from(routeCoordinate
        .map((e) => GeoPoint(latitude: e.latitude, longitude: e.longitude)));
    double distanceEnMetres =
        await distance2point(myLocationResult!.g, firstLocationResult!.g);
    int lastIndex = routeCoordinate.length - 1;

    print("km= $distanceEnMetres");
    await controller.drawRoadManually(
      taxiyol,
      const RoadOption(
          zoomInto: true,
          roadColor: Colors.blueAccent,
          roadWidth: 10,
          roadBorderWidth: 15),
    );
    controller.addMarker(
        GeoPoint(
            latitude: routeCoordinate[0].latitude,
            longitude: routeCoordinate[0].longitude),
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 200,
            color: Colors.blue,
          ),
        ));
    controller.addMarker(
        GeoPoint(
            latitude: routeCoordinate[lastIndex].latitude,
            longitude: routeCoordinate[lastIndex].longitude),
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 200,
            color: Color.fromARGB(255, 0, 0, 212),
          ),
        ));
    // showBottomm((distanceEnMetres / 1000).ceilToDouble());
  }
}

// class OSMLayersChoiceWidget extends StatelessWidget {
//   final Function(CustomTile? layer) setLayerCallback;
//   final GeoPoint centerPoint;
//   OSMLayersChoiceWidget({
//     required this.setLayerCallback,
//     required this.centerPoint,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           height: 102,
//           width: 342,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           alignment: Alignment.center,
//           margin: const EdgeInsets.only(top: 8),
//           child: PointerInterceptor(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     setLayerCallback(CustomTile.publicTransportationOSM());
//                   },
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox.square(
//                         dimension: 64,
//                         child: Image.asset(
//                           'assets/transport.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       const Text("Transportation"),
//                     ],
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     setLayerCallback(CustomTile.cycleOSM());
//                   },
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox.square(
//                         dimension: 64,
//                         child: Image.asset(
//                           'assets/cycling.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       const Text("CycleOSM"),
//                     ],
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     setLayerCallback(null);
//                   },
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox.square(
//                         dimension: 64,
//                         child: Image.asset(
//                           'assets/earth.png',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       const Text("OSM"),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
