import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddGroup extends StatefulWidget {
  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  late File image;
  List groups = [], selected = [];
  atStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    var userId = prefs.getString("userId");
    var UType = prefs.getString("UType");

    if (UType != 'E') {
      var res =
          await http.get(Uri.parse(API + "/group/AllMembers?regNo=$userId"));
      //print(res.body);
      groups = jsonDecode(res.body);

      setState(() {});
    } else {
      var res = await http.get(Uri.parse(API + "/group/AllMembersForteacher"));
      //print(res.body);
      groups = jsonDecode(res.body);

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    atStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400]!.withOpacity(.79),
        title: Center(
          child: Text(
            "Create A New Group",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var Owner_Id = prefs.getString(
                "userId",
              );

              String filename = await uploadFile(image);
              filename = filename.replaceAll('"', "");
              print(filename);

              // ignore: unused_local_variable
              var res = await http.get(
                Uri.parse(API +
                    "/Group/CreateGroup?Owner_Id=$Owner_Id&Group_Title=${groupName.text}&Group_Pic=$filename"),
              );
              print(res.body);

              String groupid = res.body.toString();

              List sending = [];
              selected.forEach((element) {
                sending.add(element['AridNo']);
              });

              var json = jsonEncode(sending);
              var res2 = await http.get(
                Uri.parse(API +
                    "/Group/AddMember?Group_Id=$groupid&members=$json&user_id=$Owner_Id"),
              );
              print(res2.body);
              Get.snackbar(
                groupName.text,
                "Created Successfully",
                snackStyle: SnackStyle.GROUNDED,
                backgroundColor: Colors.green[100],
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.close(1);
            },
            icon: Icon(
              Icons.done_outline_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: TextFormField(
                  controller: groupName,
                  decoration: InputDecoration(
                    hintText: "Enter Group Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(70),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                child: Column(
                  children: [
                    Text('Select an image for group'),
                    Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.green,
                      size: 50,
                    ),
                  ],
                ),
                onPressed: () async {
                  if (await Permission.storage.request().isGranted) {
                    final picker = ImagePicker();
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      image = File(pickedFile.path);
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
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
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: groups.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      child: CachedNetworkImage(
                        imageUrl:
                            "$download/ProfilePics/${groups[index]['AridNo']}.jpg",
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.person_outline_rounded,
                                //color: Colors.blue,
                                size: 25),
                      ),
                    ),
                    trailing: IconButton(
                      icon: groups[index]['Id'] == 0
                          ? Icon(Icons.add_circle_outline_rounded)
                          : Icon(Icons.done_outline_rounded),
                      onPressed: () {
                        if (groups[index]['Id'] == 0) {
                          selected.add(groups[index]);
                          groups[index]['Id'] = 1;
                          setState(() {});
                        } else {
                          selected.removeWhere((element) =>
                              element['AridNo'] == groups[index]['AridNo']);
                          groups[index]['Id'] = 0;
                          setState(() {});

                          print(groups[index]['Id']);
                        }
                      },
                    ),
                    title: Text("" +
                        groups[index]['Name'] +
                        " " +
                        groups[index]['AridNo']),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
