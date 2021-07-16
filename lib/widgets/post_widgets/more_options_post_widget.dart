//SHOW MORE OPTIONS DIALOG BOX

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/config.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

showMoreDialog(BuildContext context, Post p) {
  // set up the buttons

  Widget pinPost = Container(
    color: Colors.white.withOpacity(.79),
    child: FlatButton(
      hoverColor: Colors.blue[100],
      child: Column(
        children: [
          Icon(
            (Icons.push_pin_outlined),
            color: Colors.blue.withOpacity(.79),
            size: 18,
          ),
          Text(
            "Pin Post",
            style: TextStyle(
              color: Colors.black.withOpacity(.79),
            ),
          ),
        ],
      ),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // ignore: unused_local_variable
        var userId = prefs.getString(
          "userId",
        );

        print(userId);

        var res = await http.get(
            Uri.parse(API + "/Post/PinPost?userId=$userId&postId=${p.pid}"));
        if (res.statusCode == 200) print("Post is Pined");
        print(res.body);
        Navigator.pop(context);
      },
    ),
  );
//POST SAVE BUTTON
  Widget savePost = Container(
    child: FlatButton(
      hoverColor: Colors.green[100],
      child: Column(
        children: [
          Icon(
            (Icons.star_border_outlined),
            color: Colors.green.withOpacity(.79),
            size: 18,
          ),
          Text(
            "Save Post",
            style: TextStyle(
              color: Colors.black.withOpacity(.79),
            ),
          ),
        ],
      ),
      onPressed: () async {
        //api /PinPost
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // ignore: unused_local_variable
        var userId = prefs.getString(
          "userId",
        );
        var likes = prefs.getString(
          "likes",
        );
        print(userId);

        var res = await http.get(Uri.parse(API +
            "/Post/SavePost?userId=$userId&postId=${p.pid}&postedName=${p.user.name}&likes=$likes&img=${p.user.imageUrl.split('/').last}"));
        if (res.statusCode == 200) print("Post is Saved");
        print(res.body);
        Navigator.pop(context);
      },
    ),
  );

  Widget cancelButton = FlatButton(
    hoverColor: Colors.red[100],
    child: Column(
      children: [
        Icon(
          (Icons.cancel_outlined),
          // hoverColor: Colors.green,
          //color: Colors.green[100],
          // color: Colors.blueGrey[200],
          color: Colors.red.withOpacity(.79),
          size: 18,
        ),
        Text(
          "Cancel",
          style: TextStyle(
            color: Colors.black.withOpacity(.79),
          ),
        ),
      ],
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Select An Option"),
    //content: Text(""),
    actions: [
      pinPost,
      p.isSaveAble == 0 ? Center() : savePost,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
