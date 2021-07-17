import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/post_controller.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/nav_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/new_post_dialog_group.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/post_container_groupwall.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_speed_dial/simple_speed_dial.dart';

//shows all posts of the corresponding group
class GroupPage extends StatefulWidget {
  final group;
  const GroupPage({Key key, this.group}) : super(key: key);
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final List<Post> posts = [];
  File img = File("");
  var userType;

  ///this is to save groups posts inside a list for showiung later
  List groupPosts = [];

  fecthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(
      "userId",
    );

    ///api/Group/GroupFetchAllPosts?Groupid=1&userID=2017-arid-3606
    var res = await http.get(Uri.parse(API +
        "/Group/GroupFetchAllPosts?Groupid=${widget.group['Group_Id']}&userId=$userId"));
    Get.find<PostController1>().clearPostGroup();
    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);

      groupPosts = data;
      print(groupPosts.first);

      await groupPosts.forEach((element) {
        //  print(element['IsPinned']);
        Post p = Post(
          pid: element["Id"],
          user: User(
            name: element['name'].toString().isEmpty ? '' : element['name'],
            imageUrl: element['dp'] == null
                ? null
                : '$download/ProfilePics/' + element['dp'],
          ),
          caption: element['Description'],
          timeAgo: element['PostedDate'],
          // timeAgo: '1 minute',

          imageUrl: element['Picture'] == null
              ? null
              : '$download/Pictures/' +
                  element['Picture'].toString().replaceAll(" ", ""),
          likes: element['likes'],
          comments: element['PostComment'],
          isAlreadyLiked: true,
          isPostPinned: false,
          isSaveAble: 1,
          shares: element['shares'],
        );
        Get.find<PostController1>().updatePostsGroup(p);
        setState(() {});
      });

      setState(() {});
      print(groupPosts.length);
    }
  }

  @override
  void initState() {
    fecthData();
    super.initState();
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
                  '${widget.group['Group_Title']}'.trim(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    // letterSpacing: -1.0,
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
              ],
            ),
            //   SliverToBoxAdapter(child: ForAI()),
            GetBuilder<PostController1>(
              init: PostController1(),
              initState: (_) {},
              builder: (_) {
                return _.group_posts.length > 0
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final Post post = _.group_posts[index];
                            return GetBuilder<PostController1>(
                              init: PostController1(),
                              initState: (_) {},
                              builder: (_) {
                                return PostContainerGroupWall(
                                    ind: index, post: post);
                              },
                            );
                          },
                          childCount: _.group_posts.length,
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            children: [
                              Text("Add A Post to your Group"),
                              CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      );
              },
            ),

            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       var d = groupPosts[index];
            //       var picture = d['Picture'].toString().trim();
            //       Post post = Post(
            //           isSaveAble: 0,
            //           user: User(
            //               imageUrl: '$download/ProfilePics/' + d['dp'],
            //               name: d['name']),
            //           pid: d['Id'],
            //           caption: d['Description'],
            //           timeAgo: d['PostedDate'],
            //           imageUrl: '$download/Pictures/' + picture,
            //           likes: d['likes'],
            //           comments: d['PostComment'],
            //           shares: 9,
            //           isPostPinned: false,
            //           isAlreadyLiked: true);

            //       return PostContainer(post: post);
            //     },
            //     childCount: Get.find<PostController1>().group_posts.length,
            //   ),
            // ),
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
                  label: 'New Post',
                  onPressed: () {
                    NewPostDialogGroup(context, widget.group['Group_Id']);
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
