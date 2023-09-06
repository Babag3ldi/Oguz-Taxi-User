// ignore_for_file: prefer_final_fields, non_constant_identifier_names, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../bottom_sheets/loading_bottom_sheet.dart';
import '../const/enums.dart';
import '../models/address_model.dart';
import 'network_class.dart';

class TarifProvider with ChangeNotifier {
  ApiStatus status = ApiStatus.nothing;
  int bottomIndex = -1;
  int lastIndex = -1;
  changeBottomSheet(int x) {
    lastIndex = bottomIndex;
    bottomIndex = x;
    notifyListeners();
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
      var response = await NetworkHandler.http.post("/tariffs/hourly/", data: jsonEncode(data));
      //print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        status = ApiStatus.success;

        if (kDebugMode) {
          print(response.data);
          print(response.data['id']);
        }
        final id = response.data['id'];
        
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

  int _idIext = 0;

  int get IDText => _idIext;

  loadingResHourlyTarif(int IDText,{ AddressModel? startingPoint, } ) async {
    status = ApiStatus.loading;
    var data = {'starting_point': startingPoint};
    try {
      var response = await NetworkHandler.http.post("/tariffs/hourly/", data: jsonEncode(data));
      //print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        status = ApiStatus.success;

        if (kDebugMode) {
          print(response.data);
          print(response.data['id']);
        }
             response.data['id'] = IDText;

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

   Future<void> fetchData() async {
    int oo = 
    //TarifProvider().loadingResHourlyTarif().IDText;
        loadingResHourlyTarif(IDText);
       
    try {
      Dio dio = Dio();
      Response response = await dio.get(
          "http://216.250.9.245:81/api/tariffs/hourly/$oo/");
       print(response);
      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  void startAdaty({required AddressModel startingPoint, required List<AddressModel> destinations, bool isAdaty = true}) async {
    status = ApiStatus.loading;
    var data = {'starting_point': startingPoint.toJson(), 'destinations': List.from(destinations.map((e) => e.toJson()))};
    //print(data);
    try {
      var response = await NetworkHandler.http.post(isAdaty ? "/tariffs/usual/" : "/tariffs/on_way/", data: jsonEncode(data));
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

  void startYolUgruna({required AddressModel startingPoint, required List<AddressModel> destinations}) async {
    status = ApiStatus.loading;
    var data = {'starting_point': startingPoint, 'destinations': destinations};
    print(data);
    try {
      var response = await NetworkHandler.http.post("/tariffs/usual/", data: jsonEncode(data));
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
