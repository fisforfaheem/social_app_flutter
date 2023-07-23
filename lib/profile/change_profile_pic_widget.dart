// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class MyLayout extends StatefulWidget {
  @override
  State<MyLayout> createState() => _MyLayoutState();
}

class _MyLayoutState extends State<MyLayout> {
  @override
  // ignore: override_on_non_overriding_member

  var emp_no;
  var userId;
  atStart() async {
    SharedPreferences pre = await SharedPreferences.getInstance();

    userId = pre.getString("userId");
    emp_no = pre.getString("userId");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    atStart();
  }

  // ignore: override_on_non_overriding_member

  // ignore: override_on_non_overriding_member
  late File image;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      // ignore: missing_required_param
      child: ElevatedButton(
        //child: Text('add post'),
        onPressed: () {
          ChangeProfilePic(context);
        },
        child: null,
      ),
    );
  }
}

ChangeProfilePic(BuildContext context) {
  File? image = null;
  // set up the buttons

  Widget imageUpload = Container(
    child: Column(
      children: [
        image != null
            ? Image.file(
                image,
                height: 100,
              )
            : Container(),
        IconButton(
          icon: Icon(
            Icons.image_rounded,
            color: Colors.green,
            size: 25,
          ),
          onPressed: () async {
            if (await Permission.storage.request().isGranted) {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);

              if (pickedFile != null) {
                image = File(pickedFile.path);
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("img", image!.path);
                print(image?.path);
              } else {
                print('No image selected.');
              }
            }
          },
        ),
      ],
    ),
  );

  // ignore: deprecated_member_use
  Widget submitButton = TextButton(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
    ),
    child: Text(
      "Submit",
    ),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var img = prefs.getString("img");
      var userId = prefs.getString("userId");
      print(".....-----" + img!);
      String filename = await uploadProfile(File(img), userId);
      filename = filename.replaceAll('"', "");
      print(filename);
      // var res = await http.get(
      //   Uri.parse(API + "/User/UpdateProfilePicture?regNo=$userId"),
      // );
      // print(res.body);
      Get.close(1);
    },
  );
  // ignore: deprecated_member_use
  Widget cancelButton = TextButton(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
    ),
    child: Text(
      "Cancel",
    ),
    onPressed: () {
      Get.close(1);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Profile Picture "),
    //content: Text(""),
    actions: [
      imageUpload,
      cancelButton,
      submitButton,
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
