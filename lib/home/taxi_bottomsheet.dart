import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:provider/provider.dart';

import '../models/search_model.dart';
import '../provider/map_controller.dart';
import '../provider/tarif_provider.dart';
import '../searches/location_search_delegate.dart';

class TaxiBottomSheet extends StatefulWidget {
  const TaxiBottomSheet({super.key});

  @override
  State<TaxiBottomSheet> createState() => _TaxiBottomSheetState();
}

class _TaxiBottomSheetState extends State<TaxiBottomSheet> {
  ValueNotifier<bool> tarifSaylandy = ValueNotifier(false);
  ValueNotifier<bool> zakazEdildi = ValueNotifier(false);
  SearchResult? myLocationResult;
  TextEditingController myLocationText = TextEditingController();
  TextEditingController firstLocationText = TextEditingController();
  TextEditingController secondLocationText = TextEditingController();
  SearchResult? firstLocationResult;
  SearchResult? secondLocationResult;
  List<ORSCoordinate> routeCoordinate = [];
  final OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf62487a5ed48035e0422f9b50b150f64edf2f');
  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (context, prov, _) {
      return SizedBox(
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
                                          gotoMyLocation();
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
                                              gotoMyLocation();

                                              await prov.controller!
                                                  .changeLocation(GeoPoint(
                                                      latitude: s
                                                          .coordinates.latitude,
                                                      longitude: s.coordinates
                                                          .longitude));
                                            } catch (e) {}
                                          }),
                                    ),
                                  ],
                                ),
                          firstLocationResult != null
                              ? Row(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          gotoFirstLocation();
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
                                              gotoFirstLocation();
                                              await prov.controller!
                                                  .changeLocation(GeoPoint(
                                                      latitude: s
                                                          .coordinates.latitude,
                                                      longitude: s.coordinates
                                                          .longitude));
                                            } catch (e) {}
                                          }),
                                    ),
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

                                                    prov.controller!
                                                        .clearAllRoads();
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
                          Consumer<TarifProvider>(builder: (context, prov, _) {
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, top: 0, right: 15),
                                  decoration: BoxDecoration(
                                      color: prov.tarif == 0
                                          ? const Color(0xFFE5E7FF)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    leading: prov.tarif == 0
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.black,
                                          )
                                        : null,
                                    title: Container(
                                        margin: prov.tarif == 0
                                            ? null
                                            : const EdgeInsets.only(left: 40),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'assets/icon/clock.png'),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text("Sagatlaýyn"),
                                          ],
                                        )),
                                    onTap: () {
                                      prov.setTarif(0);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, top: 10, right: 15),
                                  decoration: BoxDecoration(
                                      color: prov.tarif == 1
                                          ? const Color(0xFFE5E7FF)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    leading: prov.tarif == 1
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.black,
                                          )
                                        : null,
                                    title: Container(
                                        margin: prov.tarif == 1
                                            ? null
                                            : const EdgeInsets.only(left: 40),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icon/car1.png',
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text("Adaty"),
                                          ],
                                        )),
                                    onTap: () {
                                      prov.setTarif(1);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, top: 10, right: 15),
                                  decoration: BoxDecoration(
                                      color: prov.tarif == 2
                                          ? const Color(0xFFE5E7FF)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListTile(
                                    leading: prov.tarif == 2
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.black,
                                          )
                                        : null,
                                    title: Container(
                                        margin: prov.tarif == 2
                                            ? null
                                            : const EdgeInsets.only(left: 40),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/icon/driving.png',
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Text("Ýol ugruna"),
                                          ],
                                        )),
                                    onTap: () {
                                      // tarif.value = 2;
                                      Provider.of<TarifProvider>(context,
                                              listen: false)
                                          .setTarif(2);
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
              }));
    });
  }

  drawTaxiRoad() async {
    final mapProv = Provider.of<MapProvider>(context, listen: false);
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

    //print("km= $distanceEnMetres");
    await mapProv.controller!.drawRoadManually(
      taxiyol,
      const RoadOption(
          zoomInto: true,
          roadColor: Colors.blueAccent,
          roadWidth: 10,
          roadBorderWidth: 15),
    );
    mapProv.controller!.addMarker(
        GeoPoint(
            latitude: routeCoordinate[0].latitude,
            longitude: routeCoordinate[0].longitude),
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 20,
            color: Colors.blue,
          ),
        ));
    mapProv.controller!.addMarker(
        GeoPoint(
            latitude: routeCoordinate[lastIndex].latitude,
            longitude: routeCoordinate[lastIndex].longitude),
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 20,
            color: Color.fromARGB(255, 0, 0, 212),
          ),
        ));
    // showBottomm((distanceEnMetres / 1000).ceilToDouble());
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

  gotoMyLocation() async {
    final mapProv = Provider.of<MapProvider>(context, listen: false);
    mapProv.controller!.addMarker(myLocationResult!.g,
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 20,
            color: Colors.blue,
          ),
        ));
    if (myLocationResult!.box == null) {
      await mapProv.controller!.goToLocation(myLocationResult!.g);
      mapProv.controller!.setZoom(stepZoom: 10);
    } else {
      await mapProv.controller!
          .zoomToBoundingBox(myLocationResult!.box!, paddinInPixel: 50);
    }
  }

  gotoFirstLocation() async {
    final mapProv = Provider.of<MapProvider>(context, listen: false);
    mapProv.controller!.addMarker(firstLocationResult!.g,
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 20,
            color: Colors.blue,
          ),
        ));
    if (firstLocationResult!.box == null) {
      await mapProv.controller!.goToLocation(firstLocationResult!.g);
      mapProv.controller!.setZoom(stepZoom: 10);
    } else {
      await mapProv.controller!
          .zoomToBoundingBox(firstLocationResult!.box!, paddinInPixel: 50);
    }
  }
}
