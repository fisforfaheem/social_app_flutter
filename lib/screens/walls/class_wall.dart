import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/post_controller.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/new_post_dialog_classwall.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/post_container_classwall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:get/get.dart';

class ClassWall extends StatefulWidget {
  @override
  _ClassWallState createState() => _ClassWallState();
}

class _ClassWallState extends State<ClassWall> {
  var userType;
  fecthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(
      "userId",
    );
    userType = prefs.getString(
      "UType",
    );
    setState(() {});
    // ignore: unused_local_variable
    var likes = prefs.getString(
      "likes",
    );
    // var pic = prefs.getString(
    //   "pic",
    // );

    print(userId);
    print(userType);

    var res = await http.get(Uri.parse(API + "/Post/ClassPosts?regNo=$userId"));

    //this removes all posts*from view when i refresh
    Get.find<PostController1>().clearPostClassWall();
    List data = jsonDecode(res.body);
    print(data.length);
    await data.forEach((element) {
      //  print(element['IsPinned']);
      Post p = Post(
        pid: element["Id"],
        user: element['isAnonymous'] == null || element['isAnonymous'] == 0
            ? User(
                name: element['OwnerName'].toString().isEmpty
                    ? ''
                    : element['OwnerName'],
                imageUrl: element['ProfilePic'] == null
                    ? null
                    : '$download/ProfilePics/' + element['ProfilePic'],
              )
            : User(
                name: "Anonymous",
                imageUrl: '$download/ProfilePics/' + 'anonymous.jpg',
              ),

        caption: element['Description'],
        timeAgo: element['Dated'],
        // timeAgo: '1 minute',

        imageUrl: element['Picture'] == null
            ? null
            : '$download/Pictures/' + element['Picture'],
        likes: element['LikeCount'],
        comments: element['comments'],
        isAlreadyLiked: element['isLiked'],
        isPostPinned: element['IsPinned'],
        isSaveAble: element['isSaveAble'],
        shares: null,
      );
      Get.find<PostController1>().updatePostsClassWall(p);
    });
    print("check ed ");
    //print(Get.find<PostController1>().class_posts.first.isAlreadyLiked);
  }

  @override
  void initState() {
    Get.put(PostController1());
    fecthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomeNavbar(
        ind: 2,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              elevation: 5.0,
              brightness: Brightness.light,
              backgroundColor: Colors.green[400].withOpacity(.79),
              flexibleSpace: FlexibleSpaceBar(
                // background: Image.asset(
                //   'images/group3.jpg',
                //   fit: BoxFit.fitWidth,
                // ),
                stretchModes: [StretchMode.blurBackground],
              ),
              shadowColor: Colors.amber,
              expandedHeight: 10,
              title: Center(
                child: Text(
                  'Class Wall',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    //  letterSpacing: -1.0,
                  ),
                ),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                // CircleButton(
                //     icon: Icons.home_outlined,
                //     iconSize: 30.0,
                //     onPressed: () {
                //       // Vibration.vibrate(duration: 10);
                //       //  Get.snackbar('😎', 'HOME', backgroundColor: Colors.white);
                //       print('Home');
                //       Get.offAll(HomeScreen());

                //       // Get.changeTheme(ThemeData.dark());
                //     }),
                // CircleButton(
                //     icon: Icons.logout_outlined,
                //     iconSize: 30.0,
                //     onPressed: () {
                //       //Vibration.vibrate(duration: 10, amplitude: 180);
                //       Get.offAll(SignIn());
                //     }),
              ],
            ),
            GetBuilder<PostController1>(
              init: PostController1(),
              initState: (_) {},
              builder: (_) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Post post = _.class_posts[index];
                      return GetBuilder<PostController1>(
                        init: PostController1(),
                        initState: (_) {},
                        builder: (_) {
                          return PostContainerClassWall(ind: index, post: post);
                        },
                      );
                    },
                    childCount: _.class_posts.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      //To see whether the user is Student or a Teacher!
      floatingActionButton: SpeedDial(
        child: Icon(Icons.add),
        closedForegroundColor: Colors.blue,
        openForegroundColor: Colors.white,
        closedBackgroundColor: Colors.white,
        openBackgroundColor: Colors.black,
        //labelsStyle: /* Your label TextStyle goes here */,
        // controller: /* Your custom animation controller goes here */,
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: Icon(Icons.post_add),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green.withOpacity(.99),
            label: 'Post',
            onPressed: () {
              NewPostDialogClassWall(context);
              //  MyLayout();
              // Get.to(() => MyLayout());
            },
            closeSpeedDialOnPressed: true,
          ),

          //  Your other SpeeDialChildren go here.
        ],
      ),
    );
  }
}
