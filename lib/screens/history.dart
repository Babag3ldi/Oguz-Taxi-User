import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
                  'History',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                      color: Colors.white),
                ),
                const SizedBox(
                  width: 35,
                ),
                Container(
                  width: 172,
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.05)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Mar 20,2023',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: sizeHeight*6.3),
            Container(
              width: sizeWidth * 92.5,
              height: sizeHeight*18,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                        child: Image.asset('assets/icon/locIcon.png'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('7958 Swift Village', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),),
                          SizedBox(height: 25,),
                          Text('105 William St, Chicago, US', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),),
                        ],
                      )
                    ],
                  ),
                  Divider(),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/icon/moneyIcon.png'),
                      SizedBox(
                        width: sizeWidth*55,
                        child: Text('\$75.00', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),)),
                      Text('Confirm', style: TextStyle(fontSize: 17, color: Color(0xFF4252FF)),),
                      Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xFFC1C0C9),
                          size: 15,
                        )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                width: sizeWidth * 92.5,
                height: sizeHeight*18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                          child: Image.asset('assets/icon/locIcon.png'),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('7958 Swift Village', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),),
                            SizedBox(height: 25,),
                            Text('105 William St, Chicago, US', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/icon/moneyIcon.png'),
                        SizedBox(
                          width: sizeWidth*55,
                          child: Text('\$75.00', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),)),
                        Text('Confirm', style: TextStyle(fontSize: 17, color: Color(0xFF4252FF)),),
                        Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFC1C0C9),
                            size: 15,
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                width: sizeWidth * 92.5,
                height: sizeHeight*18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                          child: Image.asset('assets/icon/locIcon.png'),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('7958 Swift Village', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),),
                            SizedBox(height: 25,),
                            Text('105 William St, Chicago, US', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),),
                          ],
                        )
                      ],
                    ),
                    Divider(),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/icon/moneyIcon.png'),
                        SizedBox(
                          width: sizeWidth*55,
                          child: Text('\$75.00', style: TextStyle(fontSize: 17, color: Color(0xFF242E42)),)),
                        Text('Confirm', style: TextStyle(fontSize: 17, color: Color(0xFF4252FF)),),
                        Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xFFC1C0C9),
                            size: 15,
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
