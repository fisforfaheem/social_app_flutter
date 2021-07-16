import 'package:meta/meta.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';

class Post {
  final User user;
  final pid;
  String caption;
  String timeAgo;
  final String imageUrl;
  int likes;
  int comments;
  int shares;
  bool isPostPinned;
  bool isAlreadyLiked;
  int isSaveAble;

  Post({
    @required this.isSaveAble,
    @required this.user,
    @required this.pid,
    @required this.caption,
    @required this.timeAgo,
    @required this.imageUrl,
    @required this.likes,
    @required this.comments,
    @required this.shares,
    @required this.isPostPinned,
    @required this.isAlreadyLiked,
  });
}
