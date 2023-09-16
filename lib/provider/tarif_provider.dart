// ignore_for_file: prefer_final_fields, non_constant_identifier_names, unused_local_variable, avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../const/enums.dart';
import '../models/address_model.dart';
import 'network_class.dart';

class TarifProvider with ChangeNotifier {
  ApiStatus status = ApiStatus.nothing;
  int bottomIndex = -1;
  int lastIndex = -1;
  dynamic event;

  int? hourlyId;
  TariffState tariffState = TariffState.none;
  changeBottomSheet(int x) {
    lastIndex = bottomIndex;
    bottomIndex = x;
    notifyListeners();
  }

  startListeningSocket() {
    final user = Hive.box('LoginBox').get('user');
    final token = user.token;

    final WebSocketChannel channel = IOWebSocketChannel.connect(
        'ws://216.250.9.245:81/ws/location/?token=$token',
        pingInterval: const Duration(seconds: 3));
    channel.stream.listen((event) {
      this.event = event;
      notifyListeners();
    });
  }

  nextBottomSheet() {
    lastIndex = bottomIndex;
    bottomIndex++;
    notifyListeners();
  }

  gotoTarif() {
    lastIndex = bottomIndex;
    bottomIndex = tarif;
    notifyListeners();
  }

  backBottomSheet() {
    print("index=$bottomIndex");
    switch (bottomIndex) {
      case 0:
        bottomIndex = -1;
        break;
      case 1:
      case 2:
      case 3:
        bottomIndex = 0;
        break;
      case 4:
        bottomIndex = lastIndex;
        break;
    }
    notifyListeners();
  }

  previousBottomSheet() {
    if (bottomIndex > 0) bottomIndex--;
    notifyListeners();
  }

  int tarif = 1;
  setTarif(int t) {
    tarif = t;
    notifyListeners();
  }

  double bottomShetHeight() {
    switch (bottomIndex) {
      case 0:
      case 1:
      case 2:
      case 3:
        return 350;
      case 4:
        return 250;
      default:
        return 250;
    }
  }

  startHourlyTarif({required AddressModel startingPoint}) async {
    status = ApiStatus.loading;
    var data = {'starting_point': startingPoint};
    try {
      var response = await NetworkHandler.http
          .post("/tariffs/hourly/", data: jsonEncode(data));
      //print(response.statusCode);
      hourlyId = response.data['id'];
      status = ApiStatus.success;

      if (tariffState == TariffState.none ||
          tariffState == TariffState.waiting) {
        Timer.periodic(const Duration(seconds: 5), (timer) async {
          checkIsTariffAccepted(url: '/tariffs/hourly/$hourlyId/');
          if (tariffState == TariffState.accepted) {
            timer.cancel();
            changeBottomSheet(5);
          }
        });
      }

      notifyListeners();
      return;
    } on DioException catch (e) {
      status = ApiStatus.error;
      tariffState = TariffState.none;
      if (kDebugMode) {
        print(e.error);

        if (e.response != null) print("Error= ${e.response!.realUri}");
        if (e.response != null) print(e.response!.data);
      }
      notifyListeners();
    }
  }

  // int _idIext = 0;

  // int get IDText => _idIext;

  checkIsTariffAccepted({url}) async {
    final response = await NetworkHandler.http.get(url);

    if (response.statusCode == 200 && response.data['driver'] != null) {
      tariffState = TariffState.accepted;
    } else {
      tariffState = TariffState.waiting;
    }
  }

  void startAdaty(
      {required AddressModel startingPoint,
      required List<AddressModel> destinations,
      bool isAdaty = true}) async {
    status = ApiStatus.loading;
    var data = {
      'starting_point': startingPoint.toJson(),
      'destinations': List.from(destinations.map((e) => e.toJson()))
    };
    //print(data);
    try {
      var response = await NetworkHandler.http.post(
          isAdaty ? "/tariffs/usual/" : "/tariffs/on_way/",
          data: jsonEncode(data));
      //print(response.statusCode);
      if (response.statusCode == 201) {
        status = ApiStatus.success;

        if (kDebugMode) {
          print(response.data);
        }

        hourlyId = response.data['id'];

        if (tariffState == TariffState.none ||
            tariffState == TariffState.waiting) {
          Timer.periodic(const Duration(seconds: 5), (timer) async {
            checkIsTariffAccepted(
                url: isAdaty
                    ? '/tariffs/usual/$hourlyId'
                    : '/tariffs/on_way/$hourlyId');
            if (tariffState == TariffState.accepted) {
              timer.cancel();
              startListeningSocket();
              changeBottomSheet(5);
            }
          });
        }

        notifyListeners();
        return;
      }
    } on DioException catch (e) {
      status = ApiStatus.error;
      tariffState = TariffState.none;
      if (kDebugMode) {
        print(e.error);

        if (e.response != null) print("Error= ${e.response!.realUri}");
        if (e.response != null) print(e.response!.data);
      }
      notifyListeners();
    }
  }

  void startYolUgruna(
      {required AddressModel startingPoint,
      required List<AddressModel> destinations}) async {
    status = ApiStatus.loading;
    var data = {'starting_point': startingPoint, 'destinations': destinations};
    print(data);
    try {
      var response = await NetworkHandler.http
          .post("/tariffs/usual/", data: jsonEncode(data));
      //print(response.statusCode);
      if (response.statusCode == 201) {
        status = ApiStatus.success;

        if (kDebugMode) {
          print(response.data);
        }

        notifyListeners();
        return;
      }
    } on DioException catch (e) {
      status = ApiStatus.error;
      if (kDebugMode) {
        print(e.error);

        if (e.response != null) print("Error= ${e.response!.realUri}");
        if (e.response != null) print(e.response!.data);
      }
      notifyListeners();
    }
  }
}
