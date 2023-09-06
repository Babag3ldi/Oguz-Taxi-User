// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../models/address_model.dart';
import '../models/search_model.dart';
import '../provider/map_controller.dart';
import '../provider/tarif_provider.dart';
import '../searches/location_search_delegate.dart';

class YolUgrunaMainBottomSheet extends StatefulWidget {
  const YolUgrunaMainBottomSheet({super.key});

  @override
  State<YolUgrunaMainBottomSheet> createState() => _YolUgrunaMainBottomSheetState();
}

class _YolUgrunaMainBottomSheetState extends State<YolUgrunaMainBottomSheet> {
  TextEditingController myLocationText = TextEditingController();
  TextEditingController firstLocationText = TextEditingController();
  TextEditingController secondLocationText = TextEditingController();

  SearchResult? myLocationResult;
  SearchResult? firstLocationResult;
  SearchResult? secondLocationResult;
  bool haveThird = false;
  List<ORSCoordinate> routeCoordinate = [];

  final OpenRouteService client = OpenRouteService(apiKey: '5b3ce3597851110001cf62487a5ed48035e0422f9b50b150f64edf2f');

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Consumer<MapProvider>(builder: (context, prov, _) {
      return SizedBox(
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.info,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 1.5, child: const Text("Bu tarifde diňe ýoluň ugryny (köçe) saýlamalydyr! "))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //first
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                //if (myLocationResult != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Image.asset("assets/icon/ic_map.png"),
                    onPressed: () {
                      if (myLocationResult == null) return;
                      gotoLocation(myLocationResult!.g, myLocationResult!.box);
                    },
                  ),
                ),
                myLocationResult != null
                    ? Container(
                        // height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                myLocationResult!.name,
                                maxLines: 2,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.asset('assets/icon/pen.png')
                            ],
                          ),
                        ))
                    : SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: 40,
                        child: TextFormField(
                            controller: myLocationText,
                            cursorColor: AppColors.primary,
                            enabled: myLocationResult == null,
                            decoration: InputDecoration(
                              hintText: 'Barmaly salgy',
                              hintStyle: const TextStyle(fontSize: 14),
                              suffixIcon: Image.asset('assets/icon/pen.png'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 0, color: Color(0xff4C5BFF)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onTap: () async {
                              final result = await showSearch(context: context, delegate: LocationSearchDelegate());
                              //controller.
                              try {
                                SearchResult s = result as SearchResult;
                                myLocationText.text = s.name;
                                myLocationResult = s;
                                // print(s.coordinates);
                                gotoLocation(myLocationResult!.g, myLocationResult!.box);

                                await prov.controller!.changeLocation(GeoPoint(latitude: s.coordinates.latitude, longitude: s.coordinates.longitude));
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            }),
                      ),
                const SizedBox(
                  width: 10,
                ),

                ///  if (myLocationResult != null)
                InkWell(
                    onTap: () {
                      setState(() {
                        myLocationText.clear();
                        myLocationResult = null;
                      });
                    },
                    child: Image.asset('assets/icon/close.png')),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            //second
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Image.asset("assets/icon/ic_map.png"),
                    onPressed: () {
                      if (myLocationResult == null) return;
                      gotoLocation(firstLocationResult!.g, firstLocationResult!.box);
                    },
                  ),
                ),
                firstLocationResult != null
                    ? Container(
                        // height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        width: MediaQuery.of(context).size.width / 1.4,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                firstLocationResult!.name,
                                maxLines: 2,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.asset('assets/icon/pen.png')
                            ],
                          ),
                        ))
                    : SizedBox(
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: 40,
                        child: TextFormField(
                            controller: firstLocationText,
                            cursorColor: AppColors.primary,
                            enabled: firstLocationResult == null,
                            decoration: InputDecoration(
                              hintText: 'Duralga 1',
                              hintStyle: const TextStyle(fontSize: 14),
                              suffixIcon: Image.asset('assets/icon/pen.png'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(width: 0, color: Color(0xff4C5BFF)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onTap: () async {
                              final result = await showSearch(context: context, delegate: LocationSearchDelegate());
                              //controller.
                              try {
                                SearchResult s = result as SearchResult;
                                firstLocationText.text = s.name;
                                firstLocationResult = s;
                                // print(s.coordinates);
                                gotoLocation(firstLocationResult!.g, firstLocationResult!.box);

                                await prov.controller!.changeLocation(GeoPoint(latitude: s.coordinates.latitude, longitude: s.coordinates.longitude));
                              } catch (e) {
                                debugPrint(e.toString());
                              }
                            }),
                      ),
                const SizedBox(
                  width: 10,
                ),

                ///  if (myLocationResult != null)
                InkWell(
                    onTap: () {
                      setState(() {
                        firstLocationText.clear();
                        firstLocationResult = null;
                      });
                    },
                    child: Image.asset('assets/icon/close.png')),
              ],
            ),

            //third
            haveThird
                ? Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: Image.asset("assets/icon/ic_map.png"),
                            onPressed: () {
                              if (myLocationResult == null) return;
                              gotoLocation(secondLocationResult!.g, secondLocationResult!.box);
                            },
                          ),
                        ),
                        secondLocationResult != null
                            ? Container(
                                // height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0, color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                width: MediaQuery.of(context).size.width / 1.4,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        secondLocationResult!.name,
                                        maxLines: 2,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Image.asset('assets/icon/pen.png')
                                    ],
                                  ),
                                ))
                            : SizedBox(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: 40,
                                child: TextFormField(
                                    controller: secondLocationText,
                                    cursorColor: AppColors.primary,
                                    enabled: secondLocationResult == null,
                                    decoration: InputDecoration(
                                      hintText: 'Duralga 2',
                                      hintStyle: const TextStyle(fontSize: 14),
                                      suffixIcon: Image.asset('assets/icon/pen.png'),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(width: 0, color: Color(0xff4C5BFF)),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: AppColors.primary, width: 1.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    onTap: () async {
                                      final result = await showSearch(context: context, delegate: LocationSearchDelegate());
                                      //controller.
                                      try {
                                        SearchResult s = result as SearchResult;
                                        secondLocationText.text = s.name;
                                        secondLocationResult = s;
                                        // print(s.coordinates);
                                        gotoLocation(secondLocationResult!.g, secondLocationResult!.box);

                                        await prov.controller!
                                            .changeLocation(GeoPoint(latitude: s.coordinates.latitude, longitude: s.coordinates.longitude));
                                      } catch (e) {
                                        debugPrint(e.toString());
                                      }
                                    }),
                              ),
                        const SizedBox(
                          width: 10,
                        ),

                        ///  if (myLocationResult != null)
                        InkWell(
                            onTap: () {
                              setState(() {
                                secondLocationText.clear();
                                secondLocationResult = null;
                                haveThird = false;
                              });
                            },
                            child: Image.asset('assets/icon/close.png')),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 50,
                  ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C5BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width / 1.2, 45),
                      maximumSize: Size(MediaQuery.of(context).size.width / 1.2, 45)),
                  onPressed: () {
                    if (myLocationResult != null && firstLocationResult != null) {
                      drawTaxiRoad();
                      Provider.of<TarifProvider>(context, listen: false).changeBottomSheet(4);

                      List<AddressModel> dest = [
                        AddressModel(
                            address: firstLocationResult!.name,
                            coordinates: Coordinate(latitude: firstLocationResult!.g.latitude, longitude: firstLocationResult!.g.longitude),
                            order: 0)
                      ];

                      Provider.of<TarifProvider>(context, listen: false).startAdaty(
                          startingPoint: AddressModel(
                              address: myLocationResult!.name,
                              coordinates: Coordinate(latitude: myLocationResult!.g.latitude, longitude: myLocationResult!.g.longitude),
                              order: 0),
                          destinations: dest);
                    }
                  },
                  child: const Text(
                    "Sargyt etmek",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
            )
          ]));
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
    mapProv.controller!.removeMarkers([myLocationResult!.g, firstLocationResult!.g]);
    taxiyol = List<GeoPoint>.from(routeCoordinate.map((e) => GeoPoint(latitude: e.latitude, longitude: e.longitude)));
    double distanceEnMetres = await distance2point(myLocationResult!.g, firstLocationResult!.g);
    int lastIndex = routeCoordinate.length - 1;

    //print("km= $distanceEnMetres");
    await mapProv.controller!.drawRoadManually(
      taxiyol,
      const RoadOption(zoomInto: true, roadColor: Colors.blueAccent, roadWidth: 10, roadBorderWidth: 15),
    );
    mapProv.controller!.addMarker(GeoPoint(latitude: routeCoordinate[0].latitude, longitude: routeCoordinate[0].longitude),
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 20,
            color: Colors.blue,
          ),
        ));
    mapProv.controller!.addMarker(GeoPoint(latitude: routeCoordinate[lastIndex].latitude, longitude: routeCoordinate[lastIndex].longitude),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Roboto'),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Bahasy: ${(distance * 1.5).ceilToDouble()} manat",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Roboto'),
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
      await mapProv.controller!.zoomToBoundingBox(myLocationResult!.box!, paddinInPixel: 50);
    }
  }

  gotoLocation(GeoPoint g, BoundingBox? box) async {
    final mapProv = Provider.of<MapProvider>(context, listen: false);
    mapProv.controller!.addMarker(g,
        markerIcon: const MarkerIcon(
          icon: Icon(
            Icons.location_on_sharp,
            size: 20,
            color: Colors.blue,
          ),
        ));
    if (box == null) {
      await mapProv.controller!.goToLocation(g);
      mapProv.controller!.setZoom(stepZoom: 7);
    } else {
      await mapProv.controller!.zoomToBoundingBox(box, paddinInPixel: 50);
    }
  }
}
