// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/config.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

///forbest fellows
class GroupPageDetails extends StatefulWidget {
  final group;

  const GroupPageDetails({Key key, this.group}) : super(key: key);

  @override
  State<GroupPageDetails> createState() => _GroupPageDetailsState();
}

class _GroupPageDetailsState extends State<GroupPageDetails> {
  List groupmembers = [];
  atStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString(
      "userId",
    );
    var UType = prefs.getString(
      "UType",
    );

    var res = await http.get(
        Uri.parse(API + "/group/GroupMembers?id=${widget.group['Group_Id']}"));

    groupmembers = jsonDecode(res.body);
    print(groupmembers);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    atStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.green[400],
              title: Text(
                'Group Details',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
              // title: Text(
              //   widget.group['Group_Title'],
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontSize: 28.0,
              //     fontWeight: FontWeight.bold,
              //     letterSpacing: -1.2,
              //   ),
              // ),
              centerTitle: false,
              floating: true,
              actions: [
                // CircleButton(
                //   icon: Icons.home,
                //   iconSize: 30.0,
                //   onPressed: () => print('Home'),
                // ),
                // CircleButton(
                //   icon: MdiIcons.accountBoxMultiple,
                //   iconSize: 30.0,
                //   onPressed: () => print('Members of This Group'),
                // ),
              ],
            ),

            ///delte button
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  Get.snackbar(
                    '',
                    "Successfully",
                    snackStyle: SnackStyle.GROUNDED,
                    backgroundColor: Colors.green[50],
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Container(
                    color: Colors.red[50],
                    padding: const EdgeInsets.all(35.0),
                    child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Delete Group',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                // ignore: missing_return
                (context, index) {
                  return InkWell(
                    // onTap: () {
                    //   Get.to(() => GroupPage(
                    //         group: groups[index],
                    //       ));
                    // },
                    child: Container(
                      //  color: Colors.orange[200],
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Icon(
                          //   Icons.people_outline_outlined,
                          //   color: Colors.blue,
                          // ),

                          // CircleAvatar(
                          //   backgroundImage: NetworkImage(download +
                          //       '/Pictures/' +
                          //       groupmembers[index]['Group_Pic']),
                          // ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            " " + groupmembers[index]['Name']['Reg_No'],
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
                childCount: groupmembers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
