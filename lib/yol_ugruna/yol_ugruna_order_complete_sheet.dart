import 'package:flutter/material.dart';

import '../const/colors.dart';


class YolUgrunaOrderCompleteBottomSheet extends StatelessWidget {
  const YolUgrunaOrderCompleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      height: sizeHeight * 45,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: sizeHeight * 1,
          ),
          Container(
            // height: 86,
            decoration: const BoxDecoration(
                color: Color(0xffF7F7F7),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16))),
            child: ListTile(
              leading: SizedBox(
                  height: 30, child: Image.asset('assets/images/taxi.png')),
              title: const Text(
                'Pylany Pylanyyew ',
                style: TextStyle(fontSize: 17),
              ),
              subtitle: const Text('Tayota Avalon '),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '25.00TMT',
                    style: TextStyle(fontSize: 18, color: AppColors.redPrimary),
                  ),
                  Text(
                    '2 min',
                    style: TextStyle(fontSize: 14, color: AppColors.greyText),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: sizeHeight * 2.5,
          ),
          Image.asset('assets/icon/check_yol.png'),
          SizedBox(
            height: sizeHeight * 2.5,
          ),
          const Text('Sagboluň!', style: TextStyle(fontSize: 20),),
         SizedBox(
            height: sizeHeight * 1,
          ),
          const Text('Siziň sargydyňyz üsdunlilkli kabul edildi', style: TextStyle(fontSize: 15),),
        ],
      ),
    );
  }
}
