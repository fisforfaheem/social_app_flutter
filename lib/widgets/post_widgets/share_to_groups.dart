// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//class for sharing posts with other groups
class Share extends StatefulWidget {
  // const Share({ Key? key }) : super(key: key);
  final Post pid;

  const Share({Key key, this.pid}) : super(key: key);

  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  List groupsList = [];
  getLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    print(userId);
    var UType = prefs.getString("UType");
    if (UType != 'E') {
      var res =
          await http.get(Uri.parse(API + "/group/GroupList?userId=$userId"));

      groupsList = jsonDecode(res.body);

      setState(() {});
    } else {
      var res = await http
          .get(Uri.parse(API + "/group/GroupListForTeacher?userId=$userId"));

      groupsList = jsonDecode(res.body);

      setState(() {});
    }
    print(groupsList);
  }

  @override
  void initState() {
    super.initState();
    getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(78.0),
          child: Text(
            'Share to',
            style: TextStyle(fontSize: 23),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: groupsList.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var userId = prefs.getString(
                "userId",
              );
              // ignore: unused_local_variable
              var userType = prefs.getString(
                "UType",
              );

              /// parameters ogf function of api
              String para =
                  "Group_Id=${groupsList[index]['Group_Id']}&pic=${widget.pid.imageUrl.split('/').last}&userID=$userId&desc=${widget.pid.caption}";
              //api calling
              var res = await http
                  .get(Uri.parse(API + "/Group/AddGroupPosts/?" + para));

              var data = jsonDecode(res.body);
              if (res.statusCode == 200) {
                Get.snackbar("sent", data.toString());

                //Get.close(1);
              } else {
                Get.snackbar("alert", data.toString());
              }

              // String para =
              //     "Group_Id=${widget.group['Group_Id']}&pic=$filename&userID=userID&desc=''";
              // var res = await http.get(Uri.parse(API + "/Group/GroupPosts/?" + para));

              // print(res.body);
              // Get.close(2);

              //   Get.to(() =>null );
            },
            child: Container(
              //  color: Colors.orange[200],
              padding: const EdgeInsets.all(16.0),
              child: Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(download +
                        '/Pictures/' +
                        groupsList[index]['Group_Pic']),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    " " + groupsList[index]['Group_Title'],
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
