import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/controllers.dart';
import 'package:flutter_facebook_responsive_ui/controllers/post_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class MyLayout extends StatefulWidget {
  @override
  State<MyLayout> createState() => _MyLayoutState();
}

class _MyLayoutState extends State<MyLayout> {
  @override
  // ignore: override_on_non_overriding_member

  // ignore: override_on_non_overriding_member
  File image;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      // ignore: missing_required_param
      child: ElevatedButton(
        //child: Text('add post'),
        onPressed: () {
          NewPostDialog(context);
        },
      ),
    );
  }
}

NewPostDialog(BuildContext context) {
  File image;
  // set up the buttons
  Widget textField = Container(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: newPostext,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green[200],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
        ),
      ),
    ),
  );
  Widget imageUpload = Container(
    child: Row(
      children: [
        image != null
            ? Image.file(
                image,
                height: 100,
              )
            : Container(),
        IconButton(
          icon: Icon(
            Icons.add_a_photo_outlined,
            color: Colors.green,
            size: 25,
          ),
          onPressed: () async {
            if (await Permission.storage.request().isGranted) {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.getImage(source: ImageSource.gallery);

              if (pickedFile != null) {
                image = File(pickedFile.path);
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString("img", image.path);
                print(image.path);
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
  Widget submitButton = FlatButton(
    hoverColor: Colors.green,
    child: Text(
      "Submit",
    ),
    onPressed: () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString(
        "userId",
      );
      var userType = prefs.getString(
        "UType",
      );
      var img = prefs.getString(
        "img",
      );
      // var wallType = prefs.getString(
      //   "wallType",
      // );

      print(img);
      String filename = await uploadFile(File(img));
      filename = filename.replaceAll('"', "");
      print(filename);
      int isSave = 1;
      print(Get.find<PostController1>().isSwitchedOn);
      if (Get.find<PostController1>().isSwitchedOn) {
        isSave = 0;
      }
      int isAnonymous = 0;
      print(Get.find<PostController2>().isAnonymousPost);
      if (Get.find<PostController2>().isAnonymousPost) {
        isAnonymous = 1;
      }
      var res = await http.get(
        Uri.parse(API +
            //how to make this dynamic????
            "/Post/AddPost?desc=${newPostext.text}&userID=$userId&wallType=BIIT&utype=$userType&filename=$filename&isSaveAble=$isSave&isAnonymousPost=$isAnonymous"),
      );

      print(res.body);
      Get.close(1);
    },
  );
  // ignore: deprecated_member_use
  Widget cancelButton = FlatButton(
    hoverColor: Colors.green,
    child: Text(
      "Cancel",
    ),
    onPressed: () {
      Get.close(1);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("New Post"),
    //content: Text(""),
    actions: [
      textField,
      imageUpload,
      Row(
        children: [
          Text("Private Post?"),
          GetBuilder<PostController1>(
            init: PostController1(),
            initState: (_) {},
            builder: (_) {
              return Switch(
                  value: _.isSwitchedOn,
                  onChanged: (f) {
                    _.updateIsSwitchedOn(f);
                  });
            },
          ),
        ],
      ),
      Row(
        children: [
          Text("Anonymous Post?"),
          GetBuilder<PostController2>(
            init: PostController2(),
            initState: (_) {},
            builder: (_) {
              return Switch(
                  value: _.isAnonymousPost,
                  onChanged: (f) {
                    _.anonymousIsSwitchedOn(f);
                  });
            },
          ),
        ],
      ),
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
