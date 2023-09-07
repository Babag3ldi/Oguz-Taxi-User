// import 'package:flutter/material.dart';
// import '../const/colors.dart';
// import '../models/driver_model.dart';
// import '../websocket/web_socket.dart';

// class SimpleOrderCompleteBottomSheet extends StatelessWidget {
//   const SimpleOrderCompleteBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double sizeWidth = MediaQuery.of(context).size.width / 100;
//     double sizeHeight = MediaQuery.of(context).size.height / 100;
//     return StreamBuilder(
//       stream: WebSocketService().messages,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           DriverModel driver = DriverModel.fromJson(snapshot.data);
//           return Container(
//             height: sizeHeight * 45,
//             width: MediaQuery.of(context).size.width,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Text(
//                   'Siziň sargydyňyz üsdunlilkli kabul edildi!',
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   // height: 86,
//                   decoration: const BoxDecoration(
//                       color: Color(0xffF7F7F7), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
//                   child: ListTile(
//                     leading: SizedBox(height: 30, child: Image.asset('assets/images/taxi.png')),
//                     title: Text(
//                       '${driver.firstName} ${driver.lastName}',
//                       style: AppColors.textStyle2,
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(driver.carNumber),
//                         Text(driver.carNumber),
//                       ],
//                     ),
//                     trailing:  Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           '25.00TMT',
//                           style: AppColors.textStyle3,
//                         ),
//                         Text(
//                           '2 min',
//                           style: AppColors.textStyle4,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
