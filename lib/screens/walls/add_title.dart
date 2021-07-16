import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/screens/walls/session_wall.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddTitle extends StatefulWidget {
  @override
  _AddTitleState createState() => _AddTitleState();
}

class _AddTitleState extends State<AddTitle> {
  final title = TextEditingController();
  List titlesList = [];
  String selectedTitle = "";

  atStart() async {
    var res = await http.get(Uri.parse(API + "/Post/AllTitles"));
    print(res.body);
    List data = jsonDecode(res.body);

    data.forEach((element) {
      titlesList.add(element['title1']);
    });

    selectedTitle = titlesList.first;
  }

  @override
  void initState() {
    super.initState();
    atStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: titlesList.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    // agar smj na ay ya dakh lena bad ma
                    Get.to(SessionWall());
                    selectedTitle = titlesList[index];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      titlesList[index],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
