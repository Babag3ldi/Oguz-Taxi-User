import 'package:flutter/material.dart';

import '../const/colors.dart';

class SimpOrderCompleteScreen extends StatelessWidget {
  const SimpOrderCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: sizeHeight * 67,
            width: MediaQuery.of(context).size.width,
            color: AppColors.simplePrimary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/check1.png'),
                SizedBox(
                  height: sizeHeight * 5,
                ),
                const Text(
                  'sagboluň we hasap\ngörkezmeli',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
          ),
          Container(
            height: sizeHeight * 33,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: sizeHeight * 4,
                ),
                SizedBox(
                  width: sizeWidth * 91,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Bahasy',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '25.00TMT',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 2.5,
                ),
                SizedBox(
                  width: sizeWidth * 91,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Geçilen ýol',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '10KM',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeHeight * 7,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpOrderCompleteScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: sizeWidth * 92,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.simplePrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Bas sahypa dolanmak',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
