import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/profile/profile_avatar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_widgets/more_options_post_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitlePostContainer extends StatelessWidget {
  final Post post;
  final ind;

  const TitlePostContainer({
    Key? key,
    required this.post,
    this.ind,
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
          post.imageUrl.replaceAll(" ", "").split('/').last != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl,
                    placeholder: (ctx, str) {
                      return CircleAvatar();
                    },

                    //fit: BoxFit.fitWidth,
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            // child: _PostStats(ind: ind, post: post),
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
    Key? key,
    required this.post,
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
            String? isDiary = prefs.getString("diary");
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

//button code like,comment
class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final void Function() onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
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
