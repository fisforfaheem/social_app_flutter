import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/profile/Profile_Page_Avatar.dart';
import 'package:flutter_facebook_responsive_ui/profile/change_profile_pic_dialog.dart';
import 'package:flutter_facebook_responsive_ui/screens/nav_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var img;
  var name;
  var classSection;
  var session;
  var emp_no;
  var userId;
  var semester;

  atStart() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    img = pre.getString("pic");
    userId = pre.getString("userId");
    name = pre.getString("FullName");
    session = pre.getString("Session");
    classSection = pre.getString("ClassSection");
    emp_no = pre.getString("emp_no");
    semester = pre.getString("Semester");

    print(img);
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
      bottomNavigationBar: CustomeNavbar(
        ind: 4,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: Container(
                  // child: Image.asset(
                  //   'images/group6.jpg',
                  //   fit: BoxFit.fitWidth,
                  // ),
                  ),
              expandedHeight: 10,
              brightness: Brightness.light,
              backgroundColor: Colors.green[400].withOpacity(.79),
              title: Center(
                child: Text(
                  'Profile',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    backgroundColor: Colors.transparent,
                    fontWeight: FontWeight.bold,
                    //  letterSpacing: -1.0,
                  ),
                ),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                CircleButton(
                  icon: Icons.add_photo_alternate_outlined,
                  iconSize: 30.0,
                  onPressed: () => ChangeProfilePicDialog(context),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {},
                        child: ProfilePageAvatar(
                          imageUrl: '$download/ProfilePics/$img.jpg',
                          // radius: 100,
                          // backgroundColor: Colors.grey[200],
                          // backgroundImage: CachedNetworkImageProvider(
                          //   '$download/ProfilePics/$img.jpg',
                          // ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  // Get.to(() => ProfilePage());
                },
                child: Container(
                  color: Colors.orange[50],
                  //  color: Colors.orange[200],
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.account_box_outlined,
                                color: Colors.green,
                              ),
                              Text(
                                'Name',
                                style: TextStyle(
                                  color: Colors.teal[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '$name',
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
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  // Get.to(() => ProfilePage());
                },
                child: Container(
                  //  color: Colors.orange[200],
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.verified_user_outlined,
                                color: Colors.green,
                              ),
                              Text(
                                'Reg. No.',
                                style: TextStyle(
                                  color: Colors.teal[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '$userId',
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
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  // Get.to(() => ProfilePage());
                },
                child: Container(
                  //  color: Colors.orange[200],
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.verified_user_outlined,
                                color: Colors.green,
                              ),
                              Text(
                                'Section',
                                style: TextStyle(
                                  color: Colors.teal[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '$classSection',
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
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  // Get.to(() => ProfilePage());
                },
                child: Container(
                  //  color: Colors.orange[200],
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          child: Column(
                            children: [
                              Icon(
                                Icons.manage_accounts,
                                color: Colors.green,
                              ),
                              Text(
                                'Session',
                                style: TextStyle(
                                  color: Colors.teal[200],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        '$session',
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
          ],
        ),
      ),
    );
  }
}
