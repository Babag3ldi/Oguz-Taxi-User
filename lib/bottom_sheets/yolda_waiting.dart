import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../models/driver_model.dart';

class YoldaBottomSheet extends StatelessWidget {
  final DriverModel driver;
  const YoldaBottomSheet({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      height: sizeHeight * 45,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 5,
              width: 60,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(
            height: sizeHeight * 1,
          ),
          Container(
            // height: 86,
            decoration: const BoxDecoration(
                color: Color(0xffF7F7F7), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
            child: ListTile(
              leading: SizedBox(height: 30, child: Image.asset('assets/images/taxi.png')),
              title: Text(
                '${driver.firstName} ${driver.lastName}',
                style: AppColors.textStyle2,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(driver.capacity.toString()),
                  Text(driver.carNumber),
                ],
              ),
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
          Image.asset('assets/icon/yellow_check.png'),
          SizedBox(
            height: sizeHeight * 2.5,
          ),
          const Text(
            'Sagboluň!',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: sizeHeight * 1,
          ),
          const Text(
            'Siziň sargydyňyz üsdunlilkli kabul edildi',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
