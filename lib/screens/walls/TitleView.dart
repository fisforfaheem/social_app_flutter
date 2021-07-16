import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/post_controller.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/title_post_container.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/title_post_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'package:get/get.dart';

class TitleView extends StatefulWidget {
  final name;
  final id;

  const TitleView({Key key, this.name, this.id}) : super(key: key);

  @override
  _SessionWallState createState() => _SessionWallState();
}

class _SessionWallState extends State<TitleView> {
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
    var id = widget.name.toString().split('_')[1];
    var res;
    res = await http.get(Uri.parse(API + "/Post/TitleAllPosts?id=$id"));
    Get.find<PostController1>().titleAllPOst.clear();
    List data = jsonDecode(res.body);

    data.forEach((element) {
      Post p = Post(
          isSaveAble: 0,
          user: User(
              name: element['OwnerName'],
              imageUrl: download +
                  "/ProfilePics/" +
                  element["ProfilePic"].toString().trim()),
          pid: element['id'],
          caption: element['Post_Desc'],
          timeAgo: DateTime.now().toIso8601String(),
          imageUrl:
              download + "/Pictures/" + element['PicName'].toString().trim(),
          likes: 7,
          comments: 6,
          shares: 9,
          isPostPinned: false,
          isAlreadyLiked: false);
      Get.find<PostController1>().updateAllTitlePOst(p);
    });

    /// api calling to show posts
    ///
    /// yha wo post add wala dialog dikahooo?

    //this removes all posts*from view when i refresh
    // Get.find<PostController1>().clearPostSessionWall();
    // List dataT = jsonDecode(res.body);
    // print(dataT.length);
    // await dataT.forEach((element) {
    //   print(dataT);
    //   Post p = Post(
    //     pid: element["Id"],
    //     user: element['isAnonymous'] == null || element['isAnonymous'] == 0
    //         ? User(
    //             name: element['OwnerName'].toString().isEmpty
    //                 ? ''
    //                 : element['OwnerName'],
    //             imageUrl: element['ProfilePic'] == null
    //                 ? null
    //                 : '$download/ProfilePics/' + element['ProfilePic'],
    //           )
    //         : User(
    //             name: "Anonymous",
    //             imageUrl: '$download/ProfilePics/' + 'anonymous.jpg',
    //           ),

    //     caption: element['Description'],
    //     timeAgo: element['CreationDate'],
    //     // timeAgo: '1 minute',

    //     imageUrl: element['Picture'] == null
    //         ? null
    //         : '$download/Pictures/' + element['Picture'],
    //     likes: element['LikeCount'],
    //     comments: element['comments'],
    //     isAlreadyLiked: element['isLiked'],
    //     isPostPinned: element['IsPinned'],
    //     isSaveAble: element['isSaveAble'],
    //     shares: 0,
    //   );
    //   Get.find<PostController1>().updatePostsSessionWall(p);
    // });
    // print("check ed ");
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
                  widget.name == null
                      ? 'Session Wall'
                      : widget.name.toString().split('_')[0],
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
            //   SliverToBoxAdapter(child: ForAI()),
            //AI post

            GetBuilder<PostController1>(
              init: PostController1(),
              initState: (_) {},
              builder: (_) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Post post = _.titleAllPOst[index];
                      return GetBuilder<PostController1>(
                        init: PostController1(),
                        initState: (_) {},
                        builder: (_) {
                          return TitlePostContainer(ind: index, post: post);
                        },
                      );
                    },
                    childCount: _.titleAllPOst.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      //To see whether the user is Student or a Teacher!
      floatingActionButton: 0 < 0
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
                    //widget.name.toString().split('_')[0];
                    TitlePOstDialog(
                        context,
                        widget.name.toString().split('_')[1],
                        widget.name.toString().split('_')[0]);
                    //  MyLayout();
                    // Get.to(() => MyLayout());
                  },
                  closeSpeedDialOnPressed: true,
                ),
                // SpeedDialChild(
                //   child: Icon(Icons.post_add_rounded),
                //   foregroundColor: Colors.black,
                //   backgroundColor: Colors.blue.withOpacity(.44),
                //   label: 'Intelligent Post',
                //   onPressed: () {
                //     NewIntelligentPostDialog(context);
                //     //setState(() {});
                //   },
                // ),
                //  Your other SpeeDialChildren go here.
              ],
            ),
    );
  }
}
