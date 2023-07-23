import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/post_controller.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/nav_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/new_Intelligent%20_post_dialog.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/new_post_dialog_sessionwall.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/post_container_sessionwall.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:get/get.dart';

class SessionWall extends StatefulWidget {
  final name;

  const SessionWall({Key? key, this.name}) : super(key: key);

  @override
  _SessionWallState createState() => _SessionWallState();
}

class _SessionWallState extends State<SessionWall> {
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

    var res;
    if (userType.toLowerCase() == 'e') {
      res = await http
          .get(Uri.parse(API + "/Post/SessionPostEmployee?empNo=$userId"));
    } else {
      res = await http
          .get(Uri.parse(API + "/Post/SessionPostStudent?regNo=$userId"));
    }

    /// api calling to show posts

    //this removes all posts*from view when i refresh
    Get.find<PostController1>().clearPostSessionWall();
    List data = jsonDecode(res.body);
    print(data.length);
    await data.forEach((element) {
      print(data);
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
        timeAgo: element['CreationDate'],
        // timeAgo: '1 minute',

        imageUrl: element['Picture'] == null
            ? null
            : '$download/Pictures/' + element['Picture'],
        likes: element['LikeCount'],
        comments: element['comments'],
        isAlreadyLiked: element['isLiked'],
        isPostPinned: element['IsPinned'],
        isSaveAble: element['isSaveAble'],
        shares: 0,
      );
      Get.find<PostController1>().updatePostsSessionWall(p);
    });
    print("check ed ");
    // print(Get.find<PostController1>().session_posts.first.isAlreadyLiked);
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
        ind: 1,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              elevation: 5.0,
              backgroundColor: Colors.green[400]?.withOpacity(.79),
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
                  widget.name == null ? 'Session Wall' : widget.name,
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
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            //   SliverToBoxAdapter(child: ForAI()),
            //AI post

            GetBuilder<PostController1>(
              init: PostController1(),
              initState: (_) {},
              builder: (_) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Post post = _.session_posts[index];
                      return GetBuilder<PostController1>(
                        init: PostController1(),
                        initState: (_) {},
                        builder: (_) {
                          return PostContainerSessionWall(
                              ind: index, post: post);
                        },
                      );
                    },
                    childCount: _.session_posts.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      //To see whether the user is Student or a Teacher!
      floatingActionButton: userType == 'S'
          ? Container()
          : SpeedDial(
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
                  label: 'Simple Post',
                  onPressed: () {
                    NewPostDialogSessionWall(context);
                    //  MyLayout();
                    // Get.to(() => MyLayout());
                  },
                  closeSpeedDialOnPressed: true,
                ),
                SpeedDialChild(
                  child: Icon(Icons.post_add_rounded),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.blue.withOpacity(.44),
                  label: 'Intelligent Post',
                  onPressed: () {
                    NewIntelligentPostDialog(context);
                    //setState(() {});
                  },
                ),
                //  Your other SpeeDialChildren go here.
              ],
            ),
    );
  }
}
