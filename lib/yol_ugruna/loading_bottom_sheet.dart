import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../const/colors.dart';

class YolUgrunaLoadingBottomSheet extends StatelessWidget {
  const YolUgrunaLoadingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      height: sizeHeight * 30,
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
          const Text(
            'Siziň sargydyňyz kabul edilýär',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: sizeHeight * 3,
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: SpinKitThreeBounce(
              color: AppColors.yolUgrunaPrimary,
              size: 38,
            ),
          ),
          SizedBox(
            height: sizeHeight * 3,
          ),
          Container(
            width: sizeWidth * 92,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:  AppColors.yolUgrunaPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Ýatyrmak',
              style: TextStyle(color: Colors.white, fontSize: 17,),
            ),
          ),
        ],
      ),
    );
  }
}
