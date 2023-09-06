class AddressModel {
  final int id;
  final String address;
  final Coordinate coordinates;
  int order;
  AddressModel({
    this.id = 0,
    required this.address,
    required this.coordinates,
    required this.order,
  });
  Map<String, dynamic> toJson() => {
        "address": address,
        "coordinate": coordinates.toJson(),
        "order": order,
      };
  @override
  String toString() {
    // TODO: implement toString
    return "$address ${coordinates.toString()}";
  }
}

class Coordinate {
  final double latitude;
  final double longitude;
  Coordinate({required this.latitude, required this.longitude});
  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
  @override
  String toString() {
    return "latitude:$latitude, longitude:$longitude";
  }
}
