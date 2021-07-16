//SHOW MORE OPTIONS DIALOG BOX

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/screens/screens.dart';
import 'package:get/get.dart';

LogOutWidget(BuildContext context) {
  // set up the buttons

//POST SAVE BUTTON
  Widget logoutButton = Container(
    color: Colors.white.withOpacity(.79),
    child: FlatButton(
      hoverColor: Colors.green[100],
      child: Column(
        children: [
          Icon(
            (Icons.logout_outlined),
            color: Colors.black,
            size: 20,
          ),
          Text(
            "Log out",
            style: TextStyle(color: Colors.red[400]),
          ),
        ],
      ),
      onPressed: () async {
        //Navigator.pop(context);
        // SharedPreferences pref = await SharedPreferences.getInstance();
        // await pref.clear();
        // print(pref.get("userId").toString());
        // await Get.snackbar(
        //     'Sign Off', 'You have been Signed out of your account',
        //     backgroundColor: Colors.white);
        Get.offAll(SignIn());
      },
    ),
  );

  Widget cancelButton = FlatButton(
    hoverColor: Colors.red[100],
    child: Container(
      child: Column(
        children: [
          Icon(
            (Icons.cancel_outlined),
            // hoverColor: Colors.green,
            color: Colors.black,
            // color: Colors.blueGrey[200],
            size: 20,
          ),
          Text(
            "Cancel",
            style: TextStyle(color: Colors.red[400]),
          ),
        ],
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Select An Option"),
    //content: Text(""),
    actions: [
      logoutButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
