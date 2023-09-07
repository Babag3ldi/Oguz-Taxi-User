import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../home/karta.dart';
import '../models/user_model.dart';
import '../provider/app_provider.dart';
import '../websocket/web_socket.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Box? loginBox;
  @override
  void initState() {
    initAll();
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const MainMap())));
  }

  initAll() async {
    if (Hive.isBoxOpen("LoginBox") == false) {
      await Hive.openBox("LoginBox");
      loginBox = Hive.box('LoginBox');
    } else {
      loginBox = Hive.box('LoginBox');
    }
    try {
      UserModel user = loginBox!.get("user");
      debugPrint("user1:${user.toString()}");
      // final webSocketService = WebSocketService();
      // webSocketService.initWebSocket(user.token);
      if (mounted) {
        await Provider.of<AppProvider>(context, listen: false).userSet(user);
      }
    } catch (e) {
      if (mounted) {
        await Provider.of<AppProvider>(context, listen: false)
            .initLocalSettings(false, "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/SplashScreens.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 32,
        ),
      ),
    ));
  }
}
