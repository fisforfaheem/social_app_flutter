import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/config.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/profile/profile_avatar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/more_options_post_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'more_options_post_widget.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: post),
                const SizedBox(height: 4.0),
                Text(post.caption),
                post.imageUrl != null
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 6.0),
              ],
            ),
          ),
          post.imageUrl.split('/').last != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl,

                    //fit: BoxFit.fitWidth,
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(post: post),
          ),
        ],
      ),
    );
  }
}

var likes;

//post Header
class _PostHeader extends StatelessWidget {
  final Post post;

  const _PostHeader({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name == null ? '' : post.user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  ),
                  post.isPostPinned == true
                      ? Icon(
                          // FluentIcons.access_time_24_regular,
                          Icons.push_pin_rounded,
                          color: Colors.grey,
                          size: 10.0,
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String isDiary = prefs.getString("diary");
            print("diary ==== " + isDiary.toString());
            if (isDiary == "yes") {
              print("3456789");
            } else {
              print(post.isSaveAble);
              showMoreDialog(context, post);
            }
          },
        ),
      ],
    );
  }
}

//SHOW MORE OPTIONS DIALOG BOX

//things like (Number of Likes,comments,shares etc)
class _PostStats extends StatefulWidget {
  final Post post;

  const _PostStats({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  State<_PostStats> createState() => _PostStatsState();
}

class _PostStatsState extends State<_PostStats> {
  bool IsLiked = false;
  @override
  void initState() {
    super.initState();
  }

  fecthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString(
      "userId",
    );
    // var postId = prefs.getString(
    //   "postId",
    // );
    // likes = prefs.getString(
    //   "likes",
    // );
    print(userId);

    /// api calling
    var res = await http.get(Uri.parse(
        API + "/Post/PostLiked?userID=$userId&postId=${widget.post.pid}"));
    print(res.body);
    setState(() {
      widget.post.isAlreadyLiked
          ? widget.post.isAlreadyLiked = false
          : widget.post.isAlreadyLiked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                likes = '${widget.post.likes}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            // Text(
            //   '${post.comments} Comments',
            //   style: TextStyle(
            //     color: Colors.grey[600],
            //   ),
            // ),
            //const SizedBox(width: 8.0),
            //this code showed how many shares for this post
            // Text(
            //   '${post.shares} Shares',
            //   style: TextStyle(
            //     color: Colors.grey[600],
            //   ),
            // )
          ],
        ),
        const Divider(),
        //Buttons of the page (like,comment,share)
        Row(
          children: [
            _PostButton(
                icon: Icon(
                  widget.post.isAlreadyLiked
                      ? MdiIcons.thumbUp
                      : MdiIcons.thumbUpOutline,
                  color: Colors.blue[600],
                  size: 20.0,
                ),
                label: 'Like',
                onTap: () {
                  fecthData();

                  ;
                }),
            _PostButton(
                icon: Icon(
                  MdiIcons.commentOutline,
                  color: Colors.grey[600],
                  size: 20.0,
                ),
                label: 'Comment',
                onTap: () {
                  // Get.to(TestMe());
                }),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () {
                // SharePostDialogBiit(context);
              },
            )
          ],
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}

//button code like,comment
class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
