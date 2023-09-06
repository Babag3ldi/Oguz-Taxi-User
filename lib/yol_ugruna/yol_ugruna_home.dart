// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../const/colors.dart';

class YolUgrunaHomeBottomSheet extends StatelessWidget {
  const YolUgrunaHomeBottomSheet({super.key});

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
          SizedBox(
             width: sizeWidth * 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icon/i_red.png'),
                const Text('Bu tarifda diňe köçe saýlap\nbilýäňiz:', textAlign: TextAlign.center,),
                const SizedBox()
              ],
            ),
          ),
          SizedBox(
            height: sizeHeight * 2,
          ),
          TextFieldWidget(sizeWidth),
          SizedBox(
            height: sizeHeight * 2,
          ),
          TextFieldWidget(sizeWidth),
          SizedBox(
            height: sizeHeight * 2,
          ),
          
          
          InkWell(
            onTap: () {
              // Navigator.push( context, MaterialPageRoute( builder: (context) => const OrderCompleteScreen(),),);
            },
            child: Container(
              width: sizeWidth * 92,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.yolUgrunaPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Sargyt etmek',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox TextFieldWidget(double sizeWidth) {
    return SizedBox(
      width: sizeWidth * 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: sizeWidth * 80,
            height: 40,
            child: TextFormField(
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: 'Duralga 1',
                hintStyle: const TextStyle(fontSize: 14),
                suffixIcon: Image.asset('assets/icon/pen.png'),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0, color: Color(0xff4C5BFF)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.primary, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Image.asset('assets/icon/close.png'),
        ],
      ),
    );
  }
}
