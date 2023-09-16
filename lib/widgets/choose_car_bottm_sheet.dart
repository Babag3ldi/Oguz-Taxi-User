import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../provider/tarif_provider.dart';

class ChooseCarBottomSheet extends StatelessWidget {
  const ChooseCarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      height: sizeHeight * 20,
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
          InkWell(
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceAround,
                  icon: Image.asset(
                    'assets/icon/check2.png',
                    height: 100,
                  ),
                  title: const Text('Howlugyň!'),
                  content: SizedBox(
                    width: sizeWidth * 70,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Siziň garaşýan maşynyňyz geldi.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, color: Color(0xff8A8A8F))),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text(
                        'Ýok',
                        style:
                            TextStyle(color: Color(0xffC8C7CC), fontSize: 17),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<TarifProvider>(context, listen: false)
                    .changeBottomSheet(6);
                    Navigator.pop(context, 'Cancel');
                      },
                      child: const Text(
                        'Hawa',
                        style:
                            TextStyle(color: Color(0xff4252FF), fontSize: 17),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Container(
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
                      style:
                          TextStyle(fontSize: 18, color: AppColors.redPrimary),
                    ),
                    Text(
                      '2 min',
                      style: TextStyle(fontSize: 12, color: AppColors.greyText),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
