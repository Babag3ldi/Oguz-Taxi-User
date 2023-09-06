import 'package:flutter/material.dart';

import '../const/colors.dart';
import 'simp_order_complate_screen.dart';

class SimpleOrderCompleteBottomSheet2 extends StatelessWidget {
  const SimpleOrderCompleteBottomSheet2({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      height: sizeHeight * 36,
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
            height: sizeHeight * 3,
          ),
          
          SizedBox(
            width: sizeWidth * 91,
            child: Row(
              children: const [
                Text(
                  'Ugran ýeriniz',
                  style: TextStyle(fontSize: 14),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                        color: Colors.grey,
                      ),
                  )),
                    Text(
                  'Selhoz instituty',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeHeight * 3,
          ),
          SizedBox(
            width: sizeWidth * 91,
            child: Row(
              children: const [
                Text(
                  'Barmaly yeriniz ',
                  style: TextStyle(fontSize: 14),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                        color: Colors.grey,
                      ),
                  )),
                    Text(
                  'Mir3',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeHeight * 3,
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
                'Ýatyrmak',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
