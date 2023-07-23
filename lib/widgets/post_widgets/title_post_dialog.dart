import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/controllers.dart';
import 'package:flutter_facebook_responsive_ui/controllers/post_controller.dart';
import 'package:flutter_facebook_responsive_ui/screens/title_model.dart';
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
  late File? image = null;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: () {
          TitlePOstDialog(context, "8", "");
        },
        child: null,
      ),
    );
  }
}

TitlePOstDialog(BuildContext context, String id, String name) {
  late File image;
  TextEditingController newPostext = TextEditingController();

  Widget textField = Container(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: newPostext,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green[200]!,
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
        Image.file(
          image,
          height: 100,
        ),
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
                  await picker.pickImage(source: ImageSource.gallery);

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

  Widget submitButton = ElevatedButton(
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

      String filename = await uploadFile(File(img!));
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

      TitlePost p = new TitlePost(
          Date: DateTime.now().toLocal(),
          Id: 1,
          Session_Post: "",
          Sposted_By: userId!,
          Type: "",
          Wall_Post_Type: name,
          Description: newPostext.text,
          Eposted_By: userId,
          Title_Id: int.parse(id),
          Post_Pic: filename);
      var jsonw = p.toJson();
      var res = await http.get(Uri.parse(API +
          //how to make this dynamic????
          "/Post/AddTitlePost?json=$jsonw"));

      print(res.body);
      Get.close(1);
    },
  );

  Widget cancelButton = ElevatedButton(
    child: Text(
      "Cancel",
    ),
    onPressed: () {
      Get.close(1);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("New Post"),
    actions: [
      textField,
      imageUpload,
      cancelButton,
      submitButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<String> uploadFile(File file) async {
  var request = http.MultipartRequest(
    "POST",
    Uri.parse(API + "/Post/UploadImage"),
  );
  request.files.add(await http.MultipartFile.fromPath("file", file.path));
  var res = await request.send();
  return res.stream.transform(utf8.decoder).single;
}
