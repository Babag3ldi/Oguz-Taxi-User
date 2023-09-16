import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';

import '../bottom_sheets/adaty_main_bottom_sheet.dart';
import '../bottom_sheets/loading_bottom_sheet.dart';
import '../bottom_sheets/sagatlayn_main_bottom_sheet.dart';
import '../bottom_sheets/tarif_bottom_sheet.dart';
import '../bottom_sheets/yol_ugruna_main_bottom_sheet.dart';
import '../login/login_page.dart';
import '../provider/app_provider.dart';
import '../provider/map_controller.dart';
import '../provider/tarif_provider.dart';
import '../simple_bottom_sheet/simple_order_complete_sheet.dart';
import '../widgets/choose_car_bottm_sheet.dart';
import '../widgets/drawer.dart';
import '../widgets/order_complate_bottom_sheet.dart';

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> with OSMMixinObserver {
  late GlobalKey<ScaffoldState> scaffoldKey;
  Position? _currentPosition;
  ORSCoordinate? latLng;
  bool loading = true;
  @override
  void initState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    fetch();
    super.initState();
  }

  fetch() async {
    await _getCurrentPosition();
    MapController controller = MapController.customLayer(
      initMapWithUserPosition: true,

      /// /const UserTrackingOption(enableTracking: false, unFollowUser: true),
      areaLimit: BoundingBox(
          east: 58.481078, // Longitude for eastern boundary
          north: 37.999194, // Latitude for northern boundary
          south: 37.782570, // Latitude for southern boundary
          west: 58.301888 // Longitude for western boundary
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
    Provider.of<MapProvider>(context, listen: false).setMap(controller, latLng);

    // controller.changeLocation(GeoPoint(latitude: latLng!.latitude, longitude: latLng!.longitude));
    // for (int i = 1; i < 6; i++) {
    //   controller.zoomIn();
    // }
  }

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

      //_getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TarifProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        print(
            "yes${Provider.of<TarifProvider>(context, listen: false).bottomIndex}");
        if (Provider.of<TarifProvider>(context, listen: false).bottomIndex !=
            -1) {
          Provider.of<TarifProvider>(context, listen: false).backBottomSheet();
          return false;
        } else {
          bool shouldPop = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Duýduruş'),
                content:
                    const Text('Siz hakykatdanam programmadan çykjakmysyňyz?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Allow back navigation
                    },
                    child: const Text('Hawa'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pop(false); // Cancel back navigation
                    },
                    child: const Text('Ýok'),
                  ),
                ],
              );
            },
          );

          return shouldPop;
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: const Drawer1(),
        floatingActionButton:
            Provider.of<MapProvider>(context).controller == null
                ? null
                : PointerInterceptor(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        onPressed: () async {
                          Provider.of<MapProvider>(context, listen: false)
                              .controller!
                              .changeLocation(GeoPoint(
                                  latitude: latLng!.latitude,
                                  longitude: latLng!.longitude));
                          for (int i = 1; i < 6; i++) {
                            Provider.of<MapProvider>(context, listen: false)
                                .controller!
                                .zoomIn();
                          }
                        },
                        child: const Icon(Icons.my_location),
                      ),
                    ),
                  ),
        body: Provider.of<MapProvider>(context).controller == null
            ? Container(
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/splash.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: SpinKitThreeBounce(
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              )
            : Stack(children: [
                OSMFlutter(
                  controller: Provider.of<MapProvider>(context).controller!,
                  // mapIsLoading:  Center(
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: const [
                  //       CircularProgressIndicator(),
                  //       Text("Karta ýüklenýär.."),
                  //     ],
                  //   ),
                  // ),
                  //
                  onMapIsReady: (isReady) {
                    if (isReady) {
                      // print("map is ready");
                    }
                  },
                  onLocationChanged: (myLocation) {
                    print(myLocation);
                  },
                  onGeoPointClicked: (geoPoint) async {},

                  // osmOption: const OSMOption(enableRotationByGesture: true),
                ),
                Positioned(
                  left: 10,
                  top: 20,
                  child: IconButton(
                    icon: Image.asset("assets/icon/draver.png"),
                    onPressed: () => scaffoldKey.currentState!.openDrawer(),
                  ),
                ),
                if (loading == false && prov.bottomIndex == -1)
                  Positioned(
                    bottom: 10,
                    left: (MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width / 1.3)) /
                        2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C5BFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          fixedSize:
                              Size(MediaQuery.of(context).size.width / 1.3, 45),
                        ),
                        onPressed: () {
                          if (Provider.of<AppProvider>(context, listen: false)
                                  .user ==
                              null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Ilki bilen login bolmaly'),
                            ));
                            Timer(const Duration(seconds: 1), () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                            });
                          } else {
                            Provider.of<TarifProvider>(context, listen: false)
                                .nextBottomSheet();
                          }
                        },
                        child: const Text(
                          "Sargyt etmek",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
                  ),
              ]),
        bottomSheet:
            prov.bottomIndex == -1
                ? null
                : SizedBox(
                    height: Provider.of<TarifProvider>(context, listen: false)
                        .bottomShetHeight(),
                    child: IndexedStack(
                      index: prov.bottomIndex,
                      children: const [
                        //const TaxiBottomSheet(),

                        TarifChooseBottomSheet(),

                        SagatlaynMainBottomSheet(),

                        AdatyMainBottomSheet(),
                        YolUgrunaMainBottomSheet(),
                        SimpleLoadingBottomSheet(),

                        ChooseCarBottomSheet(),
                        OrderCompleteBottomSheet(),

                        

                        // SimpleOrderCompleteBottomSheet(),


                        // SimpleOrderCompleteBottomSheet(),

                      ],
                    ),
                  ),
      ),
    );
  }



  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
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

  Future<void> mapIsInitialized() async {
    await Provider.of<MapProvider>(context, listen: false)
        .controller!
        .setZoom(zoomLevel: 12);
    if (mounted) {
      Provider.of<MapProvider>(context, listen: false)
          .controller!
          .changeLocation(GeoPoint(
              latitude: latLng!.latitude, longitude: latLng!.longitude));
    }
    for (int i = 1; i < 4; i++) {
      // ignore: use_build_context_synchronously
      Provider.of<MapProvider>(context, listen: false).controller!.zoomIn();
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await mapIsInitialized();
    }
  }
}
