import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/profile/change_profile_pic_widget.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyLayout(),
    );
  }
}

class MyLayout extends StatefulWidget {
  @override
  State<MyLayout> createState() => _MyLayoutState();
}

class _MyLayoutState extends State<MyLayout> {
  @override
  // ignore: override_on_non_overriding_member

  // ignore: override_on_non_overriding_member
  late File? image = null;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      // ignore: missing_required_param
      child: ElevatedButton(
        //child: Text('add post'),
        onPressed: () {
          // Get.off(2);
          ChangeProfilePicDialog(context);
        },
        child: null,
      ),
    );
  }
}

ChangeProfilePicDialog(BuildContext context) {
  // ignore: unused_local_variable
  File image;
  // set up the buttons

  // ignore: deprecated_member_use
  Widget uploadButton = TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green[200]!),
    ),
    onPressed: () async {
      //Get.close(1);
      Get.to(ChangeProfilePic(context));
    },
    child: Text("Upload New Picture"),
  );
  Widget cancelButton = TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green[200]!),
    ),
    onPressed: () {
      Get.close(1);
    },
    child: Text("Cancel"),
  );
  Widget defaultImage = TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.green[200]!),
    ),
    onPressed: () {
      Get.close(1);
    },
    child: Text("Default Picture"),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Change Profile Picture"),
    //content: Text(""),
    actions: [
      uploadButton,
      defaultImage,
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
