import 'package:flutter_facebook_responsive_ui/models/user_model.dart';

class CommentModel {
  final User user;
  final String comment;
  final DateTime time;

  const CommentModel({
    required this.user,
    required this.comment,
    required this.time,
  });
}
