// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyLayout(),
    );
  }
}

class MyLayout extends StatefulWidget {
  @override
  State<MyLayout> createState() => _MyLayoutState();
}

class _MyLayoutState extends State<MyLayout> {
  @override
  // ignore: override_on_non_overriding_member

  //File image;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      // ignore: missing_required_param
      child: ElevatedButton(
        //child: Text('add post'),
        onPressed: () {
          NewIntelligentPostDialog(context);
        },
      ),
    );
  }
}

NewIntelligentPostDialog(BuildContext context) {
  Widget timeTable = FlatButton(
    color: Colors.green[100],
    hoverColor: Colors.green,
    child: Text("Timetable",
        style: TextStyle(
          fontSize: 18,
        )),
    onPressed: () {
      Get.close(1);
    },
  );

  Widget dateSheet = FlatButton(
    color: Colors.green[100],
    hoverColor: Colors.green,
    child: Text("Datesheet",
        style: TextStyle(
          fontSize: 18,
        )),
    onPressed: () {
      Get.close(1);
    },
  );
  Widget result = FlatButton(
    hoverColor: Colors.green,
    color: Colors.green[100],
    child: Text("Result",
        style: TextStyle(
          fontSize: 18,
        )),
    onPressed: () {
      Get.close(1);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Pick Intelligent Post Type",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
    //content: Text(""),
    actions: [
      timeTable,
      dateSheet,
      result,
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
