import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
export 'package:dio/dio.dart';

class NetworkHandler {
  static Dio http = Dio();

  // static Connectivity connectivity = Connectivity();
  //server
  static const baseUrl = //"http://192.168.11.69:8000/api/";
      "http://216.250.9.245:81/api/";

  static Future<void> setRequestHeaders({required isLoggedIn, String token = "", String locale = "tk"}) async {
    (http.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-language': locale,
      'satyjy': true,
      // 'auth-token':
      //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzZWxsZXJJZCI6MSwibG9naW4iOiJqYXN1ciIsIkFjY2VzcyI6MCwic2VydmljZV9zaG9wX2lkIjowLCJzaG9wX2lkIjoxLCJ0eXBlX3Nob3AiOjEsImlhdCI6MTY0NzMyMTM5NiwiZXhwIjo1MjQ3MzIxMzk2fQ.lQn21ygRIe5wf9_zupHQguH4GZAXfrZyiSpChY1AGNw',

      //'language': locale,
    };
    debugPrint("Token $token");
    //if (UserProvider.token != "") headers['auth-token'] = UserProvider.token;
    if (isLoggedIn) {
      //  print("da");
      headers['Authorization'] = "Bearer $token"; //AppProvider.accessToken;
    }
    http.options.baseUrl = baseUrl;
    http.options.headers = headers;
    http.options.connectTimeout = const Duration(milliseconds: 10000);
    http.options.receiveTimeout = const Duration(milliseconds: 20000);

    //print(headers);
  }

  // static initNetworkClass() async {
  //   await setRequestHeaders();
  // }

  // static Future<bool> checkInternet() async {
  //   //return true if no internet
  //   var connectivityResult = await connectivity.checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
  //     //  print(connectivityResult);
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
