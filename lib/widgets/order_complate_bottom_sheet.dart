import 'package:flutter/material.dart';

import '../const/colors.dart';
import 'order_complate_screen.dart';

class OrderCompleteBottomSheet extends StatelessWidget {
  const OrderCompleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      height: sizeHeight * 35,
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
            height: sizeHeight * 2,
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
                ],
              ),
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
                  'Wagty',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                Text(
                  '04:02 Min',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: sizeHeight * 2.5,
          ),
          InkWell(
            onTap: () {
              Navigator.push( context, MaterialPageRoute( builder: (context) => const OrderCompleteScreen(),),);
            },
            child: Container(
              width: sizeWidth * 92,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xff4C5BFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Sargydy tamamlamak',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
