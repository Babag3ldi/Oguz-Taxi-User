import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../home/karta.dart';
import '../login/login_page.dart';
import '../provider/app_provider.dart';
import '../provider/tarif_provider.dart';
import '../screens/history.dart';
import '../screens/notification.dart';
import '../screens/settings.dart';
import '../screens/wallet.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({super.key});

  @override
  Widget build(BuildContext context) {
    // double sizeWidth = MediaQuery.of(context).size.width / 100;
    // double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        // padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/drawerBack.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Provider.of<AppProvider>(context).user == null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 40)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                              Navigator.of(context).pop();
                            },
                            child: const Text("Içeri gir"))
                        :
                        // Image.asset('assets/images/profile.png'),
                        Text(
                            "+993 ${Provider.of<AppProvider>(context).user!.name}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                )),
          ),
          ListTile(
            leading: Image.asset('assets/icon/homeIcon.png'),
            title: const Text(
              'Baş Sahypa',
              style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainMap(),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset('assets/icon/walletIcon.png'),
            title: const Text(
              'Bahalar',
              style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Wallet(),
                ),
              );
            },
          ),

          ListTile(
            leading: Image.asset('assets/icon/historyIcon.png'),
            title: const Text(
              'Taryhym',
              style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const History(),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset('assets/icon/notificationIcon.png'),
            title: const Text(
              'Bildirişler',
              style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Notifications(),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset('assets/icon/settingsIcon.png'),
            title: const Text(
              'Sazlamalar',
              style: TextStyle(color: Color(0xFF242E42), fontSize: 17),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/icon/logoutIcon.png',
              color: Colors.red,
            ),
            title: const Text(
              'Ulgamdan çykmak',
              style: TextStyle(color: Colors.red, fontSize: 17),
            ),
            onTap: () {
              Provider.of<TarifProvider>(context, listen: false)
                  .changeBottomSheet(-1);
              Provider.of<AppProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
