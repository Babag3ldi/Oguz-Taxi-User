import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/historyBack.png'),
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
                  'My Wallet',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: Colors.white),
                ),
                const SizedBox(
                  width: 35,
                ),
                Container(
                  width: 116,
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.05)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/icon/coinIcon.png'),
                      Text(
                        '2500',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: sizeHeight*9),
            Container(
              height: sizeHeight*22,
              width: sizeWidth*92,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
              ),
              child: Column(
                children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                      child: Image.asset('assets/icon/moneyOval.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 18),
                        Text(
                        'Cash',
                        style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Default Payment Method',
                        style: TextStyle(color: Color(0xFFC8C7CC), fontSize: 17),
                      ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Divider(),
                SizedBox(height: sizeHeight*1.5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0,),
                      child: Column(
                        children: [
                          Text(
                          'Balance',
                          style: TextStyle(color: Color(0xFFC8C7CC), fontSize: 17),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          '\$2500',
                          style: TextStyle(color: Color(0xFFF52D56), fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        ],
                      ),
                    ),
                     Column(
                      children: [
                        Text(
                        'Expires',
                        style: TextStyle(color: Color(0xFFC8C7CC), fontSize: 17),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        '09/21',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      ],
                    ),
                    SizedBox(),
                  ],
                )
              ]),
            ),
            SizedBox(
              height: sizeHeight * 7,
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
                      'Payment Methods',
                      style: TextStyle(
                        fontSize: 17,
                      ),
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
              width: sizeWidth*100,
              height: sizeHeight*10,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border(
                  top:
                      BorderSide(width: 1.0, color: Colors.grey.shade200 ),
                  bottom:
                      BorderSide(width: 1.0, color: Colors.grey.shade200),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:15.0, top: 5),
                        child: Text('Coupon', style: TextStyle(fontSize: 17),),
                      ),
                       Container(
                        alignment: Alignment.centerRight,
                        width: sizeWidth * 64,
                        child: Text(
                          '3',
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFFC8C7CC)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:15.0),
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
                        padding: const EdgeInsets.only(left:15.0),
                        child: Text('Integral Mall', style: TextStyle(fontSize: 17),),
                      ),
                       Container(
                        alignment: Alignment.centerRight,
                        width: sizeWidth * 57,
                        child: Text(
                          '4500',
                          style:
                              TextStyle(fontSize: 17, color: Color(0xFFC8C7CC)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:15.0),
                        child: forwardIcon(),
                      )
                    ],
                  ),
                ],
              ),
            ),  
          ])
      )
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