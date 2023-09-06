import 'dart:convert';

import 'address_model.dart';


class DriverModel {
  final int id;
  final String firstName;
  final String lastName;
  final int capacity;
  final String carNumber;
  final Coordinate location;
  final bool isHourlyTariffDriver;
  final bool isUsualTariffDriver;
  final bool isOnWayTariffDriver;
  final bool isAvailable;

  DriverModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.capacity,
    required this.carNumber,
    required this.location,
    required this.isHourlyTariffDriver,
    required this.isUsualTariffDriver,
    required this.isOnWayTariffDriver,
    required this.isAvailable,
  });

  factory DriverModel.fromRawJson(String str) => DriverModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        id: json["id"],
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        capacity: json["capacity"] ?? 0,
        carNumber: json["car_number"] ?? "",
        location: Coordinate.fromJson(json["location"]),
        isHourlyTariffDriver: json["is_hourly_tariff_driver"] ?? false,
        isUsualTariffDriver: json["is_usual_tariff_driver"] ?? false,
        isOnWayTariffDriver: json["is_on_way_tariff_driver"] ?? false,
        isAvailable: json["is_available"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "capacity": capacity,
        "car_number": carNumber,
        "location": location,
        "is_hourly_tariff_driver": isHourlyTariffDriver,
        "is_usual_tariff_driver": isUsualTariffDriver,
        "is_on_way_tariff_driver": isOnWayTariffDriver,
        "is_available": isAvailable,
      };
}
