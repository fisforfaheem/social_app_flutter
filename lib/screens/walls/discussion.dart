import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../title_model.dart';

class Discussion extends StatefulWidget {
  @override
  State<Discussion> createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  File image;
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
        backgroundColor: Colors.green[400].withOpacity(.79),
        title: Center(
          child: Text(
            "Discussion title",
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

              // String filename = await uploadFile(image);
              // filename = filename.replaceAll('"', "");
              // print(filename);
              TitleAdd title = TitleAdd(title1: groupName.text);
              var json = title.toJson();
              // ignore: unused_local_variable
              var res = await http.get(
                Uri.parse(API + "/Post/AddTitle?title=${groupName.text}"),
              );
              print(res.body);

              Get.snackbar(
                groupName.text,
                "Created Successfully",
                snackStyle: SnackStyle.GROUNDED,
                backgroundColor: Colors.green[100],
                snackPosition: SnackPosition.BOTTOM,
              );
              // Get.to(TitleView());
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
                    hintText: "Enter Interest Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(70),
                    ),
                  ),
                ),
              ),
              // ignore: deprecated_member_use
            ],
          ),
          SizedBox(
            height: 8,
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: groups.length,
          //     itemBuilder: (ctx, index) {
          //       return InkWell(
          //         onTap: () {},
          //         child: ListTile(
          //           leading: CircleAvatar(
          //             radius: 22,
          //             child: CachedNetworkImage(
          //               imageUrl:
          //                   "$download/ProfilePics/${groups[index]['AridNo']}.jpg",
          //               fit: BoxFit.fill,
          //               placeholder: (context, url) =>
          //                   CircularProgressIndicator(),
          //               errorWidget: (context, url, error) =>
          //                   Icon(Icons.person_outline_rounded,
          //                       //color: Colors.blue,
          //                       size: 25),
          //             ),
          //           ),
          //           trailing: IconButton(
          //             icon: groups[index]['Id'] == 0
          //                 ? Icon(Icons.add_circle_outline_rounded)
          //                 : Icon(Icons.done_outline_rounded),
          //             onPressed: () {
          //               if (groups[index]['Id'] == 0) {
          //                 selected.add(groups[index]);
          //                 groups[index]['Id'] = 1;
          //                 setState(() {});
          //               } else {
          //                 selected.removeWhere((element) =>
          //                     element['AridNo'] == groups[index]['AridNo']);
          //                 groups[index]['Id'] = 0;
          //                 setState(() {});

          //                 print(groups[index]['Id']);
          //               }
          //             },
          //           ),
          //           title: Text("" +
          //               groups[index]['Name'] +
          //               " " +
          //               groups[index]['AridNo']),
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
