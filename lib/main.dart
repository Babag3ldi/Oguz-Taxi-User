import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'home/karta.dart';
import 'login/login_page.dart';
import 'models/user_model.dart';
import 'provider/app_provider.dart';
import 'provider/login_api.dart';
import 'provider/map_controller.dart';
import 'provider/tarif_provider.dart';
import 'screens/splash_screen.dart';
import 'search_example.dart';

Future<void> main() async {
  await Hive.initFlutter();
  // await Hive.openBox<UserModel>("LoginBox");
  Hive.registerAdapter<UserModel>(UserAdapter());

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => TarifProvider()),
    ChangeNotifierProvider(create: (_) => LoginApi()),
    ChangeNotifierProvider(create: (_) => AppProvider()),
    ChangeNotifierProvider(create: (_) => MapProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oguz Taxi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/picker-result": (ctx) => LocationAppExample(),
        "/splash": (ctx) => SplashScreen(),
        "/search": (ctx) => SearchPage(),
        "/map": (ctx) => const MainMap(),
        "/login": (ctx) => const LoginScreen(),
      },
    );
  }
}
