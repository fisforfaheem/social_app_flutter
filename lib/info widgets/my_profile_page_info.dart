// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() => runApp(MyApp());

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
//   var userType;
//   fecthData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var userId = prefs.getString(
//       "userid",
//     );
//     userType = prefs.getString(
//       "UType",
//     );
//     print(userId);
//     print(userType);
//     setState(() {});
//   }

//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(18.0),
//       // ignore: missing_required_param
//       child: ElevatedButton(
//         //child: Text('add post'),
//         onPressed: () {
//           showMyProfileInfoAlertDialog(context);
//         },
//       ),
//     );
//   }
// }

// showMyProfileInfoAlertDialog(BuildContext context) {
//   // set up the buttons
//   // Widget text = Container(
//   //   child: Padding(
//   //     padding: const EdgeInsets.all(18.0),
//   //     child: TextField(
//   //       controller: newPostext,
//   //     ),
//   //   ),
//   // );
//   // Widget imageUpload = Container(
//   //   child: IconButton(
//   //     icon: Icon(
//   //       Icons.image_rounded,
//   //       color: Colors.green,
//   //       size: 25,
//   //     ),
//   //     onPressed: () {},
//   //   ),
//   // );

//   // ignore: deprecated_member_use
//   Widget okButton = FlatButton(
//     child: Text(
//       "ok",
//     ),
//     onPressed: () async {
//       Get.close(1);
//       // ignore: unused_local_variable
//       // var res = await http.post(
//       //   Uri.parse(API + "/Post/AddPost/"),
//       //   body: {},
//       //   encoding: Encoding.getByName("post"),
//       // );
//     },
//   );

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text(
//         "This Page tells shows you profile picture and your details, you can change your photo here too"),
//     //content: Text(""),
//     actions: [
//       okButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
