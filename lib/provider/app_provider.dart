import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/user_model.dart';
import 'network_class.dart';

class AppProvider with ChangeNotifier {
  bool drawerOpened = false;
  int locationId = -1;
  String localeCode = 'tr';
  UserModel? user;
  Box? loginBox;
  Box? dataBox;
  String token = "";

  logout() async {
    user = null;
    if (loginBox == null) {
      if (Hive.isBoxOpen("LoginBox") == false) {
        await Hive.openBox("LoginBox");
        loginBox = Hive.box('LoginBox');
      } else {
        loginBox = Hive.box('LoginBox');
      }
      loginBox!.clear();
    }

    notifyListeners();
  }

  userSet(UserModel userModel) async {
    user = userModel;
    await getLocale();
    initLocalSettings(true, userModel.token);
    //notifyListeners();
  }

  setLocation(int id) {
    locationId = id;
    notifyListeners();
  }

  changeDrawerStatus(bool opened) {
    drawerOpened = opened;
    notifyListeners();
  }

  Future<void> initLocalSettings(bool islogin, String token) async {
    this.token = token;

    await NetworkHandler.setRequestHeaders(
        isLoggedIn: islogin, token: token, locale: localeCode);

    // bool _isLight = await SharedPreferencesHelper.getThemeMode();
    // if (_isLight) {
    //   initLightTheme();
    // } else {
    //   initDarkTheme();
    // }
    return;
  }

  getLocale() async {
    if (dataBox == null) {
      if (Hive.isBoxOpen("dataBox") == false) {
        await Hive.openBox("dataBox");
        dataBox = Hive.box('dataBox');
      } else {
        dataBox = Hive.box('dataBox');
      }
    }
    localeCode = dataBox!.get('locale') ?? 'tr';
    notifyListeners();
  }

  saveInHive(String name, dynamic value) async {
    if (dataBox == null) {
      if (Hive.isBoxOpen("dataBox") == false) {
        await Hive.openBox("dataBox");
        dataBox = Hive.box('dataBox');
      } else {
        dataBox = Hive.box('dataBox');
      }
    }
    dataBox!.put(name, value);
  }

  changeLocale({String lc = 'tr'}) async {
    localeCode = lc;
    if (dataBox == null) {
      if (Hive.isBoxOpen("dataBox") == false) {
        await Hive.openBox("dataBox");
        dataBox = Hive.box('dataBox');
      } else {
        dataBox = Hive.box('dataBox');
      }
    }
    // String? val = dataBox!.get('token');
    if (Hive.isBoxOpen("LoginBox") == false) {
      await Hive.openBox("LoginBox");
      loginBox = Hive.box('LoginBox');
    } else {
      loginBox = Hive.box('LoginBox');
    }
    UserModel? user = loginBox!.get("user", defaultValue: null);
    if (user != null) {
      await NetworkHandler.setRequestHeaders(
          isLoggedIn: true, token: user.token, locale: localeCode);
    } else {
      await NetworkHandler.setRequestHeaders(
          isLoggedIn: false, locale: localeCode);
    }
    notifyListeners();

    dataBox!.put("locale", localeCode);
  }
}
