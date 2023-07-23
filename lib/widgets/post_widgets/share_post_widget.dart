// // ignore_for_file: deprecated_member_use

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_responsive_ui/config/api.dart';

// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// void main() => runApp(MyApp());

// List groupsList = [];

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: MyLayout(),
//     );
//   }
// }

// class MyLayout extends StatefulWidget {
//   @override
//   State<MyLayout> createState() => _MyLayoutState();
// }

// class _MyLayoutState extends State<MyLayout> {
//   @override
//   // ignore: override_on_non_overriding_member

//   // File image;

//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(18.0),
//       // ignore: missing_required_param
//       child: ElevatedButton(
//         //child: Text('add post'),
//         onPressed: () {
//           SharePostDialog(context);
//         },
//       ),
//     );
//   }
// }

// SharePostDialog(BuildContext context) {
//   getLists();
//   // set up the buttons

//   Widget timeTable = TextButton(
//     color: Colors.green[100],
//     style: ButtonStyle(
//     child: Text("IT Boys Only",
//         style: TextStyle(
//           fontSize: 18,
//         )),
//     onPressed: () {
//       Get.close(1);
//     },
//   );

//   AlertDialog alert = AlertDialog(
//     title: Text("Share Dialog",
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         )),
//     //content: Text(""),
//     actions: [
//       Expanded(
//         child: Container(
//           height: 200,
//           child: ListView.builder(
//             itemCount: groupsList.length,
//             itemBuilder: (ctx, index) {
//               return InkWell(
//                 onTap: () {
//                   //   Get.to(() =>null );
//                 },
//                 child: Container(
//                   //  color: Colors.orange[200],
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(download +
//                             '/Pictures/' +
//                             groupsList[index]['Group_Pic']),
//                       ),
//                       SizedBox(
//                         width: 15,
//                       ),
//                       Text(
//                         " " + groupsList[index]['Group_Title'],
//                         style: TextStyle(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Scaffold(
//         body: Expanded(
//           child: Container(
//             height: 200,
//             child: ListView.builder(
//               itemCount: groupsList.length,
//               itemBuilder: (ctx, index) {
//                 return InkWell(
//                   onTap: () {
//                     //   Get.to(() =>null );
//                   },
//                   child: Container(
//                     //  color: Colors.orange[200],
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         CircleAvatar(
//                           backgroundImage: NetworkImage(download +
//                               '/Pictures/' +
//                               groupsList[index]['Group_Pic']),
//                         ),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           " " + groupsList[index]['Group_Title'],
//                           style: TextStyle(
//                             fontSize: 25,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

// getLists() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var userId = prefs.getString("userId");
//   var UType = prefs.getString("UType");
//   if (UType != 'E') {
//     var res =
//         await http.get(Uri.parse(API + "/group/GroupList?userId=$userId"));

//     groupsList = jsonDecode(res.body);
//   } else {
//     var res = await http
//         .get(Uri.parse(API + "/group/GroupListForTeacher?userId=$userId"));

//     groupsList = jsonDecode(res.body);
//   }
// }
