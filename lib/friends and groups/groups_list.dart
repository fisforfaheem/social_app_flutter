import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/friends%20and%20groups/add_group.dart';
import 'package:flutter_facebook_responsive_ui/profile/profile_avatar.dart';
import 'package:flutter_facebook_responsive_ui/screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//saima ka group wall mera group group list hai
class GroupsList extends StatefulWidget {
  @override
  State<GroupsList> createState() => _GroupsListState();
}

class _GroupsListState extends State<GroupsList> {
  List groupsList = [];
  atStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
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
  }

  @override
  void initState() {
    super.initState();
    atStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomeNavbar(
        ind: 4,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: Container(),
              expandedHeight: 10,
              brightness: Brightness.light,
              backgroundColor: Colors.green[400].withOpacity(.79),
              title: Center(
                child: Text(
                  'Groups',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    backgroundColor: Colors.transparent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.2,
                  ),
                ),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                CircleButton(
                    icon: Icons.add,
                    iconSize: 30.0,
                    onPressed: () {
                      Get.to(AddGroup());
                      // NewGroupDialog(context);
                    }),
              ],
            ),
            groupsList.length == 0
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        children: [
                          Text(" No Group Found"),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      // ignore: missing_return
                      (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => GroupPage(
                                  group: groupsList[index],
                                ));
                          },
                          child: Container(
                            //  color: Colors.orange[200],
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                ProfileAvatar(
                                  imageUrl: download +
                                      '/Pictures/' +
                                      groupsList[index]['Group_Pic'],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  " " + groupsList[index]['Group_Title'],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: groupsList.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
