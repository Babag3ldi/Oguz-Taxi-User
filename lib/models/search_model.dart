import 'dart:convert';

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:open_route_service/open_route_service.dart';

class LocationSuggests {
  final Geometry geometry;
  final Properties properties;
  final List<double>? bbox;

  LocationSuggests({
    required this.geometry,
    required this.properties,
    this.bbox,
  });

  factory LocationSuggests.fromRawJson(String str) =>
      LocationSuggests.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocationSuggests.fromJson(Map<String, dynamic> json) =>
      LocationSuggests(
        geometry: Geometry.fromJson(json["geometry"]),
        properties: Properties.fromJson(json["properties"]),
        bbox: json["bbox"] == null
            ? []
            : List<double>.from(json["bbox"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "properties": properties.toJson(),
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
      };
}

class Geometry {
  final String type;
  final List<double> coordinates;
  double get latitude => coordinates[1];
  double get longitude => coordinates[0];

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  final String id;
  final String? gid;
  final String layer;
  final String name;
  final String region;
  final String label;
  final String? street;
  final String? housenumber;

  Properties({
    required this.id,
    this.gid,
    required this.layer,
    required this.name,
    required this.region,
    required this.label,
    this.street,
    this.housenumber,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        id: json["id"],
        gid: json["gid"],
        layer: json["layer"],
        name: json["name"],
        region: json["region"],
        label: json["label"],
        street: json["street"],
        housenumber: json["housenumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gid": gid,
        "layer": layer,
        "name": name,
        "region": region,
        "label": label,
        "street": street,
        "housenumber": housenumber,
      };
}

class SearchResult {
  final String name;
  final ORSCoordinate coordinates;
  GeoPoint get g => GeoPoint(
      latitude: coordinates.latitude, longitude: coordinates.longitude);
  final BoundingBox? box;
  SearchResult(
      {required this.name, required this.coordinates, required this.box});
}
