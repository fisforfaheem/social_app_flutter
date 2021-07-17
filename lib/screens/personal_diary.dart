import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/post_controller.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/screens/nav_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/post_container_diary.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonalDiary extends StatefulWidget {
  @override
  State<PersonalDiary> createState() => _PersonalDiaryState();
}

class _PersonalDiaryState extends State<PersonalDiary> {
  List<Post> posts = [];
  var type = '';
  atStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("diary", "yes");
    var userId = prefs.getString(
      "userId",
    );
    type = prefs.getString("UType");
    print(userId);

    /// api calling to show posts
    var res =
        await http.get(Uri.parse(API + "/Post/SavePostView?userId=$userId"));

    Get.find<PostController1>().clearPostDiary();
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print(type);

      //var users = <User>[];
      //user .... std ,,, emp
      // List std = data['std'];
      // std.forEach((element) {
      //   users.add(
      //     User(
      //       name: element['St_firstname'] + " " + element['St_lastname'],
      //       imageUrl: element['userId'] + ".jpg",
      //     ),
      //   );
      // });
      await data.forEach((element) {
        //  print(element['IsPinned']);

        Post p = Post(
          shares: 0,
          pid: element['Id'],
          user: User(
            name: element['PostedBy'],
            imageUrl: download + '/ProfilePics/' + element['postedprofile'],
          ),
          caption: element['Description'],
          timeAgo: element['PostedDate'],
          // timeAgo: '1 minute',
          imageUrl: '$download/Pictures/' + element['Picture'],
          likes: 0,
          comments: element['comments'],
          isAlreadyLiked: element['isLiked'], isSaveAble: 1,

          ///not working why?
          isPostPinned: element['IsPinned'],
        );
        Get.find<PostController1>().updatePostsDiary(p);
      });
      print("check ed ");

      setState(() {});
    } else {
      print(res.body);
    }
  }

  @override
  void initState() {
    super.initState();
    atStart();
    print("Personal Diary");
  }

  atDispose() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("diary", "");
    print("remove");
  }

  @override
  void dispose() {
    atDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomeNavbar(
          //ind: type.toLowerCase() == 'e' ? 2 : 3,
          ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  // background: Image.asset(
                  //   'images/user1.jpg',
                  //   fit: BoxFit.fitWidth,
                  // ),
                  ),
              expandedHeight: 10,
              brightness: Brightness.light,
              backgroundColor: Colors.green.withOpacity(.79),
              title: Center(
                child: Text(
                  'Personal Diary',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    //   letterSpacing: -1.2,
                  ),
                ),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                // CircleButton(
                //   icon: Icons.info_outlined,
                //   iconSize: 30.0,
                //   onPressed: () => print(''),
                // ),
              ],
            ),
            GetBuilder<PostController1>(
              init: PostController1(),
              initState: (_) {},
              builder: (_) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final Post post = _.diary_posts[index];

                      return PostContainerDiary(ind: index, post: post);
                    },
                    childCount: _.diary_posts.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
