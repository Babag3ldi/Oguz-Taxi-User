import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:open_route_service/open_route_service.dart';

import '../models/search_model.dart';

class LocationSearchDelegate extends SearchDelegate {
  final OpenRouteService client = OpenRouteService(apiKey: '5b3ce3597851110001cf62487a5ed48035e0422f9b50b150f64edf2f');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.red,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          // Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<GeoJsonFeatureCollection>(
      future: client.geocodeSearchGet(
          text: query, boundaryCountry: 'TM', boundaryCircleCoordinate: const ORSCoordinate(latitude: 37.9500, longitude: 58.3833)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.error));
        } else {
          List<GeoJsonFeature> pr = snapshot.data!.features;
          return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemCount: pr.length,
              itemBuilder: (BuildContext innerContext, int index) {
                Properties props = Properties.fromJson(pr[index].properties);
                double ini = MediaQuery.of(context).size.width / 1.4;
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      close(
                          context,
                          SearchResult(
                              name: props.name,
                              box: BoundingBox.fromGeoPoints(
                                  List<GeoPoint>.from(pr[index].bbox!.map((e) => GeoPoint(latitude: e.latitude, longitude: e.longitude)))),
                              coordinates: pr[index].geometry.coordinates[0][0]));
                    },
                    child: Container(
                      width: ini,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: 5),
                          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                                width: ini,
                                child: Text(
                                  props.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            if (props.street != null) SizedBox(width: ini, child: Text(" Köçe: ${props.street} ")),
                            if (props.housenumber != null) SizedBox(width: ini, child: Text("Jaý: ${props.housenumber}"))
                          ]),
                          const Icon(Icons.location_pin),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<GeoJsonFeatureCollection>(
      future: client.geocodeSearchGet(
          text: query, boundaryCountry: 'TM', boundaryCircleCoordinate: const ORSCoordinate(latitude: 37.9500, longitude: 58.3833)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child:  CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.search));
        } else {
          List<GeoJsonFeature> pr = snapshot.data!.features;
          return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemCount: pr.length,
              itemBuilder: (BuildContext innerContext, int index) {
                Properties props = Properties.fromJson(pr[index].properties);
                double ini = MediaQuery.of(context).size.width / 1.4;
                //print(pr[index].geometry.coordinates.toString());
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(
                        FocusNode(),
                      );
                      print("result=");
                      print(pr[index].geometry.coordinates[0]);
                      close(
                          context,
                          SearchResult(
                              name: props.name,
                              box: pr[index].bbox == null
                                  ? null
                                  : BoundingBox.fromGeoPoints(
                                      List<GeoPoint>.from(pr[index].bbox!.map((e) => GeoPoint(latitude: e.latitude, longitude: e.longitude)))),
                              coordinates: pr[index].geometry.coordinates[0][0]));
                    },
                    child: Container(
                      width: ini,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: 5),
                          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            SizedBox(
                                width: ini,
                                child: Text(
                                  props.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            if (props.street != null) SizedBox(width: ini, child: Text(" Köçe: ${props.street} ")),
                            if (props.housenumber != null) SizedBox(width: ini, child: Text("Jaý: ${props.housenumber}"))
                          ]),
                          const Icon(Icons.location_pin),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}
