import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';

TextEditingController loginUserID = TextEditingController();
TextEditingController loginUserPassword = TextEditingController();
TextEditingController newPostext = TextEditingController();
TextEditingController newGroupName = TextEditingController();
TextEditingController groupName = TextEditingController();

uploadFile(File fileAfterSavingLocallay) async {
  String filenamep = '';
  var stream, len;

  stream = http.ByteStream(
      // ignore: deprecated_member_use
      DelegatingStream.typed(fileAfterSavingLocallay.openRead()));
  len = await fileAfterSavingLocallay.length();
  String url = API + '/files/UploadPostPicture';
  var req = http.MultipartRequest("POST", Uri.parse(url));
  filenamep = fileAfterSavingLocallay.path.toString().split('/').last;
  var multi = new http.MultipartFile(
    "msg",
    stream,
    len,
    filename: filenamep,
  );
  req.files.add(multi);
  var respose = await req.send();
  print(respose.reasonPhrase);
  if (respose.statusCode == 200) {
    //msg = respose.reasonPhrase.toUpperCase();
    await http.Response.fromStream(respose).then((value) async {
      print(value.body);
      filenamep = value.body;
    });
  } else {}
  return filenamep;
}

uploadProfile(File fileAfterSavingLocallay, regNo) async {
  Directory dir = await getExternalStorageDirectory();
  var path = dir.path +
      '/${regNo}_new.' +
      fileAfterSavingLocallay.path.split('.').last;
  File file = File(path);
  file.writeAsBytesSync(fileAfterSavingLocallay.readAsBytesSync());
  fileAfterSavingLocallay = file;
  print("object");
  print(fileAfterSavingLocallay);
  String filenamep = '';
  var stream, len;
  try {
    stream = http.ByteStream(
        // ignore: deprecated_member_use
        DelegatingStream.typed(fileAfterSavingLocallay.openRead()));
    len = await fileAfterSavingLocallay.length();
    String url = API + '/User/UpdateProfilePicture';
    var req = http.MultipartRequest("POST", Uri.parse(url));
    filenamep = fileAfterSavingLocallay.path.toString().split('/').last;
    var multi = new http.MultipartFile(
      "msg",
      stream,
      len,
      filename: filenamep,
    );
    req.files.add(multi);
    print(regNo);
    var respose = await req.send();
    print(respose.statusCode);
    if (respose.statusCode == 200) {
      //msg = respose.reasonPhrase.toUpperCase();
      await http.Response.fromStream(respose).then((value) async {
        print(".....------.....-----  " + value.body);
        filenamep = value.body;
      });
    } else {
      print(respose.statusCode);
    }
  } catch (e) {
    print("Error=====> " + e.toString());
  }
  return filenamep;
}
