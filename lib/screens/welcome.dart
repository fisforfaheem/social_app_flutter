// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_facebook_responsive_ui/screens/screens.dart';
// import 'package:get/get.dart';
// //import 'package:vibration/vibration.dart';

// class Welcome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Container(
//               // height: double.infinity,
//               // width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.all(38.0),
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       'images/Landing-Page1.png',
//                       fit: BoxFit.contain,
//                       alignment: Alignment.center,
//                     ),
//                     Center(
//                       child: Container(
//                         child: ElevatedButton(
//                           style: ButtonStyle(),
//                           child: Text("   Welcome "),
//                           onPressed: () {
//                             //Vibration.vibrate(duration: 10, amplitude: 180);
//                             Get.to(() => SignIn());
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
// }
