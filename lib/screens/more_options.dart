import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_facebook_responsive_ui/screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/screens/walls/discussion.dart';
import 'package:flutter_facebook_responsive_ui/widgets/logout_widget.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:get/get.dart';

class MoreOptions extends StatelessWidget {
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
              flexibleSpace: Container(
                  // child: Image.asset(
                  //   'images/group1.jpg',
                  //   fit: BoxFit.fitWidth,
                  // ),
                  ),
              expandedHeight: 10,
              backgroundColor: Colors.green.withOpacity(.79),
              title: Center(
                child: Text(
                  'More Options',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    backgroundColor: Colors.transparent,
                    fontWeight: FontWeight.bold,
                    //  letterSpacing: -1.2,
                  ),
                ),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                CircleButton(
                    icon: Icons.logout_outlined,
                    iconSize: 30.0,
                    onPressed: () {
                      LogOutWidget(context);
                    }),
              ], systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            //My profile
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  Get.to(() => PersonalDiary());
                },
                child: Container(
                  //  color: Colors.orange[200],
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.green,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Personal Diary',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //My profile
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  Get.to(() => Discussion());
                },
                child: Container(
                  //  color: Colors.orange[200],
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle_outlined,
                        color: Colors.green,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'discussion',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //GROUPS
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  Get.to(() => GroupsList());
                },
                child: Container(
                  //  color: Colors.orange[200],
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.groups_outlined,
                        color: Colors.green,
                        size: 35,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Groups',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Friends
            // SliverToBoxAdapter(
            //   child: InkWell(
            //     onTap: () {
            //       Get.to(() => AddAFriend());
            //     },
            //     child: Container(
            //       //  color: Colors.orange[200],
            //       padding: const EdgeInsets.all(16.0),
            //       child: Row(
            //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Icon(
            //             Icons.people_outline_outlined,
            //             color: Colors.blue,
            //             size: 35,
            //           ),
            //           SizedBox(
            //             width: 15,
            //           ),
            //           Text(
            //             'Friends',
            //             style: TextStyle(
            //               fontSize: 30,
            //               fontWeight: FontWeight.w700,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            //Logout
          ],
        ),
      ),
    );
  }
}
