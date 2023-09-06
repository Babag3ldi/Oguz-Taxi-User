import 'package:flutter/material.dart';

import 'acount.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/notiBack.png'), fit: BoxFit.fill)),
        child: Column(
          children: [
            SizedBox(
              height: sizeHeight * 2.5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizeHeight * 8.5,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Accounts(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                height: sizeHeight * 11,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey.shade200),
                    bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/profile.png'),
                    ),
                    SizedBox(
                      width: sizeWidth * 71,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: sizeHeight * 2.2,
                          ),
                          const Text(
                            'Larry Davis',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: sizeHeight * 0.6,
                          ),
                          const Text(
                            'Gold Member',
                            style: TextStyle(fontSize: 15, color: Color(0xFF8A8A8F)),
                          ),
                        ],
                      ),
                    ),
                    forwardIcon()
                  ],
                ),
              ),
            ),
            SizedBox(
              height: sizeHeight * 2.9,
            ),
            Container(
              width: sizeWidth * 100,
              height: sizeHeight * 16,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade200),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 5),
                        child: Text(
                          'Notifications',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                  const Divider(
                    indent: 160,
                    endIndent: 160,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Security',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                  const Divider(
                    indent: 160,
                    endIndent: 160,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 5),
                        child: Text(
                          'Language',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sizeHeight * 2.9,
            ),
            Container(
              width: sizeWidth * 100,
              height: sizeHeight * 16,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade200),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 5),
                        child: Text(
                          'Clear cache',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                  const Divider(
                    indent: 160,
                    endIndent: 160,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Terms & Privacy Policy',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                  const Divider(
                    indent: 160,
                    endIndent: 160,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 5),
                        child: Text(
                          'Contact us',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: sizeHeight * 5,
            ),
            Container(
              width: sizeWidth * 100,
              height: sizeHeight * 5.2,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade200),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
                ),
              ),
              child: const Center(
                  child: Text(
                'Log out',
                style: TextStyle(fontSize: 17, color: Color(0xFFC8C7CC)),
              )),
            )
          ],
        ),
      ),
    );
  }

  Icon forwardIcon() {
    return const Icon(
      Icons.arrow_forward_ios_rounded,
      color: Color(0xFFC1C0C9),
      size: 15,
    );
  }
}
