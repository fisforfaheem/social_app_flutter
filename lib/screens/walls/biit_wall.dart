import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/post_controller.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/nav_screen.dart';
import 'package:flutter_facebook_responsive_ui/screens/walls/TitleView.dart';
import 'package:flutter_facebook_responsive_ui/screens/walls/add_title.dart';
import 'package:flutter_facebook_responsive_ui/screens/walls/discussion.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/new_Intelligent%20_post_dialog.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/new_post_dialog_biitwall.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/post_container_biitwall.dart';
import 'package:flutter_facebook_responsive_ui/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

    var res = await http
        .get(Uri.parse(API + "/Post/BIITWall?userId=$userId&type=biit"));
    //this removes all posts*from view when i refresh
    Get.find<PostController1>().clearPostbiitwall_posts();
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
      Get.find<PostController1>().updatePostsBIITWall(p);
    });
    print("check ed ");
    // print(Get.find<PostController1>().biitwall_posts.first.isAlreadyLiked);
  }

  String selectedTitle = "";

  atStart() async {
    Get.find<PostController1>().titlesList.clear();
    var res = await http.get(Uri.parse(API + "/Post/AllTitles"));
    print(res.body);
    List data = jsonDecode(res.body);

    data.forEach((element) {
      Get.find<PostController1>()
          .updateTitles(element['title1'] + "_" + element['id'].toString());
    });

    //isy b wo controller ma kroo jsay post show ki ha jldi ?

    selectedTitle = Get.find<PostController1>().titlesList.first;
    setState(() {});
  }

  @override
  void initState() {
    Get.put(PostController1());
    fecthData();
    atStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // atStart();
    return Scaffold(
      bottomNavigationBar: CustomeNavbar(
        ind: 0,
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
              expandedHeight: 20,
              title: Text(
                'BIIT WALL',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  //  letterSpacing: -1.0,
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

                Container(
                  child: Row(
                    children: [
                      Text(
                        'Add New Topic',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                          //  letterSpacing: -1.0,
                        ),
                      ),
                      CircleButton(
                          icon: Icons.add,
                          iconSize: 22.0,
                          onPressed: () {
                            //Vibration.vibrate(duration: 10, amplitude: 180);
                            Get.to(Discussion());
                          }),
                    ],
                  ),
                ),
              ],
            ),
            //   SliverToBoxAdapter(child: ForAI()),
            //AI post
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       if (index == 0) {
            //         final Post post = Post(
            //             isSaveAble: 0,
            //             user: User(
            //                 name: "ADMIN",
            //                 imageUrl: download + "/Pictures/" + "null.jpg"),
            //             pid: 7,
            //             caption: "Intelligance POst ",
            //             timeAgo: DateTime.now().toString(),
            //             imageUrl: "imageUrl",
            //             likes: 9,
            //             comments: 9,
            //             shares: 4,
            //             isPostPinned: true,
            //             isAlreadyLiked: true);
            //         post.caption = "";
            //         return ForAI(
            //           post: post,
            //         );
            //       }
            //       return Container();
            //     },
            //     childCount: Get.find<PostController1>().biitwall_posts.length,
            //   ),
            // ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return InkWell(
                    hoverColor: Colors.green[200],
                    focusColor: Colors.grey,
                    borderRadius: BorderRadius.circular(220),
                    splashColor: Colors.green,
                    onTap: () {
                      Get.to(TitleView(
                          name: Get.find<PostController1>().titlesList[index]));
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.green[50]),
                      // color: Colors.green[50],
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        Get.find<PostController1>()
                            .titlesList[index]
                            .split('_')[0],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'arial',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
                childCount: Get.find<PostController1>().titlesList.length,
              ),
            ),
            GetBuilder<PostController1>(
              init: PostController1(),
              initState: (_) {},
              builder: (_) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Post post = _.biitwall_posts[index];
                      return GetBuilder<PostController1>(
                        init: PostController1(),
                        initState: (_) {},
                        builder: (_) {
                          return PostContainerBiitWall(ind: index, post: post);
                        },
                      );
                    },
                    childCount: _.biitwall_posts.length,
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
                    NewPostDialog(context);
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
