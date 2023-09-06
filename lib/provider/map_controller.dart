import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:open_route_service/open_route_service.dart';

class MapProvider with ChangeNotifier {
  MapController? controller;
  setMap(MapController ctr, ORSCoordinate? latLng) {
    controller = ctr;
    // controller!.changeLocation(GeoPoint(latitude: latLng!.latitude, longitude: latLng!.longitude));
    // for (int i = 1; i < 6; i++) {
    //   controller!.zoomIn();
    // }
    notifyListeners();
  }

  MapController get ctr => controller!;
  //  = MapController.customLayer(
  //   initMapWithUserPosition: const UserTrackingOption(enableTracking: false, unFollowUser: true),
  //   areaLimit: BoundingBox(
  //     east: 37.966667,
  //     north: 37.733333,
  //     south: 37.966667,
  //     west: 37.733333,
  //   ),
  //   customTile: CustomTile(
  //     sourceName: "openstreetmap",
  //     tileExtension: ".png",
  //     minZoomLevel: 10,
  //     maxZoomLevel: 19,
  //     urlsServers: [TileURLs(url: "https://a.tile.openstreetmap.org/")],
  //     tileSize: 256,
  //   ),
  // );
}
