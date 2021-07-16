import 'package:flutter_facebook_responsive_ui/models/post_model.dart';
import 'package:get/get.dart';

class PostController1 extends GetxController {
  bool isSwitchedOn = false;
  List<Post> biitwall_posts = [];
  List<Post> class_posts = [];
  List<Post> session_posts = [];
  List<Post> group_posts = [];
  List<Post> diary_posts = [];

  List<String> titlesList = [];
  List<Post> titleAllPOst = [];

  updateAllTitlePOst(posts) {
    titleAllPOst.add(posts);
    update();
  }

  updateTitles(posts) {
    titlesList.add(posts);
    update();
  }

  updatePostsBIITWall(posts) {
    biitwall_posts.add(posts);
    update();
  }

  updatePostsDiary(posts) {
    diary_posts.add(posts);
    update();
  }

  updatePostsClassWall(posts) {
    class_posts.add(posts);
    update();
  }

  updatePostsSessionWall(posts) {
    session_posts.add(posts);
    update();
  }

  updatePostsGroup(posts) {
    group_posts.add(posts);
    update();
  }

  updatePostsPersonalDiary(posts) {
    diary_posts.add(posts);
    update();
  }

  clearPostClassWall() {
    class_posts.clear();
    update();
  }

  clearPostDiary() {
    diary_posts.clear();
    update();
  }

  clearPostSessionWall() {
    session_posts.clear();
    update();
  }

  clearPostGroup() {
    group_posts.clear();
    update();
  }

  clearPostbiitwall_posts() {
    biitwall_posts.clear();
    update();
  }

  //try making it dynamic!
  updatePostsLikedBiitwall(index) {
    biitwall_posts[index].isAlreadyLiked
        ? biitwall_posts[index].likes--
        : biitwall_posts[index].likes++;
    biitwall_posts[index].isAlreadyLiked =
        !biitwall_posts[index].isAlreadyLiked;

    update();
  }

  updatePostsLikedDiray(index) {
    diary_posts[index].isAlreadyLiked
        ? diary_posts[index].likes--
        : diary_posts[index].likes++;
    diary_posts[index].isAlreadyLiked = !diary_posts[index].isAlreadyLiked;

    update();
  }

  updatePostsLikedClasswall(index) {
    class_posts[index].isAlreadyLiked
        ? class_posts[index].likes--
        : class_posts[index].likes++;
    class_posts[index].isAlreadyLiked = !session_posts[index].isAlreadyLiked;

    update();
  }

  updatePostsLikedGroupwall(index) {
    group_posts[index].isAlreadyLiked
        ? group_posts[index].likes--
        : group_posts[index].likes++;
    group_posts[index].isAlreadyLiked = !group_posts[index].isAlreadyLiked;

    update();
  }

  updatePostsLikedSessionwall(index) {
    session_posts[index].isAlreadyLiked
        ? session_posts[index].likes--
        : session_posts[index].likes++;
    session_posts[index].isAlreadyLiked = !session_posts[index].isAlreadyLiked;

    update();
  }

  updateIsSwitchedOn(f) {
    isSwitchedOn = f;
    update();
  }
}

class PostController2 extends GetxController {
  bool isAnonymousPost = false;
  anonymousIsSwitchedOn(f) {
    isAnonymousPost = f;
    update();
  }
}
