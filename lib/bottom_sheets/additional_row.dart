import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../widgets/custom_dialog.dart';

class AdditionalRow extends StatelessWidget {
  final double sizeHeight;
  final Color color;
  const AdditionalRow({super.key, required this.sizeHeight, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeHeight * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Spacer(),
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height: sizeHeight * 4,
                  child: Image.asset(
                    'assets/icon/payment.png',
                    color: color,
                  )),
              SizedBox(
                height: sizeHeight * 1.5,
              ),
              Text(
                'Töleg',
                style: TextStyle(color: color, fontSize: 15),
              )
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog();
                },
              );
            },
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    height: sizeHeight * 4,
                    child: Image.asset(
                      'assets/icon/chat.png',
                      color: color,
                    )),
                SizedBox(
                  height: sizeHeight * 1.5,
                ),
                Text(
                  'Bellik',
                  style: TextStyle(color: color, fontSize: 15),
                )
              ],
            ),
          ),
          const Spacer(),
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height: sizeHeight * 4,
                  // width: sizeWidth * 20,
                  child: Image.asset(
                    'assets/icon/calendar.png',
                    color: color,
                  )),
              SizedBox(
                height: sizeHeight * 1.3,
              ),
              Text(
                'Sene',
                style: TextStyle(color: color, fontSize: 15),
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
