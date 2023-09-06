import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/notiBack.png'),
                fit: BoxFit.fill)),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: Colors.white),
                ),
                const SizedBox(
                  width: 35,
                ),
                Image.asset('assets/icon/trash.png'),
              ],
            ),
            SizedBox(
              height: sizeHeight * 6,
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                Container(
                  height: 88,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Image.asset('assets/icon/yes.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: sizeHeight * 2.5,
                        ),
                        Text(
                          'System',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeHeight * 0.8,
                        ),
                        Text(
                          'Your booking #1234 has been suc...',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    )
                  ]),
                ),
                Divider(),
                Container(
                  height: 88,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Image.asset('assets/icon/money.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: sizeHeight * 2.5,
                        ),
                        Text(
                          'System',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeHeight * 0.8,
                        ),
                        Text(
                          'Your booking #1234 has been suc...',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    )
                  ]),
                ),
                Divider(),
                Container(
                  height: 88,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Image.asset('assets/icon/money.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: sizeHeight * 2.5,
                        ),
                        Text(
                          'System',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeHeight * 0.8,
                        ),
                        Text(
                          'Your booking #1234 has been suc...',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    )
                  ]),
                ),
                Divider(),
                Container(
                  height: 88,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Image.asset('assets/icon/not.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: sizeHeight * 2.5,
                        ),
                        Text(
                          'System',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeHeight * 0.8,
                        ),
                        Text(
                          'Your booking #1234 has been suc...',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    )
                  ]),
                ),
                Divider(),
                Container(
                  height: 88,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Image.asset('assets/icon/wallet.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: sizeHeight * 2.5,
                        ),
                        Text(
                          'System',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeHeight * 0.8,
                        ),
                        Text(
                          'Your booking #1234 has been suc...',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    )
                  ]),
                ),
                Divider(),
                Container(
                  height: 88,
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 20),
                      child: Image.asset('assets/icon/money.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: sizeHeight * 2.5,
                        ),
                        Text(
                          'System',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: sizeHeight * 0.8,
                        ),
                        Text(
                          'Your booking #1234 has been suc...',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    )
                  ]),
                ),
                Divider(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
