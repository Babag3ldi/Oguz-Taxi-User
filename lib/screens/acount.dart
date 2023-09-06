import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'My Account',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 9,
                  // width: sizeWidth*15,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/profile.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizeHeight * 4.3,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: sizeHeight * 5.2,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.grey.shade200),
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Level',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: sizeWidth * 70,
                    child: Text(
                      'Gold Member',
                      style: TextStyle(fontSize: 17, color: Color(0xFFC8C7CC)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: forwardIcon(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: sizeHeight * 2.9,
            ),
            Container(
              width: sizeWidth * 100,
              height: sizeHeight * 33,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 5),
                        child: Text(
                          'Name',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: sizeWidth * 69,
                        child: Text(
                          'Babageldi Orunov',
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFFC8C7CC)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                  Divider(
                    indent: 160,
                    endIndent: 160,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Email',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: sizeWidth * 68,
                        child: Text(
                          'babageldiorunov@gmail.com',
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFFC8C7CC)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                  Divider(
                    indent: 160,
                    endIndent: 160,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Gender',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: sizeWidth * 66,
                        child: Text(
                          'Male',
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFFC8C7CC)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                  Divider(
                    indent: 160,
                    endIndent: 160,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Birthday',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: sizeWidth * 64,
                        child: Text(
                          'April 8, 2002',
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFFC8C7CC)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                  Divider(
                    indent: 160,
                    endIndent: 160,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                        child: Text(
                          'Phone number',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Container(
                    alignment: Alignment.centerRight,
                    width: sizeWidth*52,
                    child: Text(
                      '+993 61 748339',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFFC8C7CC)
                      ),
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
          ],
        ),
      ),
    );
  }

  Icon forwardIcon() {
    return Icon(
      Icons.arrow_forward_ios_rounded,
      color: Color(0xFFC1C0C9),
      size: 15,
    );
  }
}
