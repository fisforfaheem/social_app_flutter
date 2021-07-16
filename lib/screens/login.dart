import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/api.dart';
import 'package:flutter_facebook_responsive_ui/controllers/controllers.dart';
//import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/screens/walls/biit_wall.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:avatar_view/avatar_view.dart';
import 'walls/biit_wall.dart';
import 'package:http/http.dart' as http;
// import 'package:vibration/vibration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget loginButtonChild = const Text(
      "Log in",
      style: TextStyle(
        color: Colors.white,
        fontFamily: "OpenSans-Regular",
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            // CircleButton(
            //   icon: Icons.info_outline_rounded,
            //   iconSize: 30.0,
            //   onPressed: () => {
            //     Get.to(AboutDialog()),
            //   },
            // ),
          ],
          flexibleSpace: Container(
            color: Colors.green.withOpacity(.79),
            height: 200,
            // child: Image.asset(
            //   'images/group2.jpg',
            //   fit: BoxFit.fitWidth,
            // ),
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Log-In",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                //letterSpacing: -1.2,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AvatarView(
                    radius: 80,
                    borderColor: Colors.orange,
                    isOnlyText: false,
                    text: Text(
                      'C',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    avatarType: AvatarType.RECTANGLE,
                    imagePath: "images/biit.jpeg",
                    onTap: () {
                      Get.to(AboutDialog());
                      AboutDialog(
                        applicationName: "BIIT SOCIAL MEDIA APP",
                        applicationVersion: 'Final',
                        applicationIcon: Image.asset('images/user1.jpg'),
                        children: [],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: loginUserID,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'User ID',
                          prefixIcon: Icon(Icons.account_box_outlined),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        obscureText: true,
                        controller: loginUserPassword,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: deprecated_member_use
                    FlatButton.icon(
                      height: 45,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green[300])),
                      color: Colors.green.withOpacity(.79),
                      label: loginButtonChild,
                      icon: Icon(Icons.login_outlined),
                      onPressed: () async {
                        //Get.to(() => HomeScreen());

                        var res = await http.get(Uri.parse(
                            "$API/User/UserLogin?username=${loginUserID.text}&password=${loginUserPassword.text}"));
                        if (res.statusCode == 200) {
                          var loginData = jsonDecode(res.body);
                          print(loginData);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                            "userId",
                            loginData['UserName'],
                          );
                          prefs.setString(
                            "UType",
                            loginData['UType'],
                          );
                          prefs.setString(
                            "FullName",
                            loginData['FullName'],
                          );
                          prefs.setString(
                            "Designation",
                            loginData['Designation'],
                          );
                          prefs.setString(
                            "Session",
                            loginData['Session'],
                          );
                          prefs.setString(
                            "ClassSection",
                            loginData['ClassSection'],
                          );
                          prefs.setString(
                            "pic",
                            loginData['pic'],
                          );

                          Get.offAll(() => HomeScreen());
                        } else {
                          loginUserID.clear();
                          loginUserPassword.clear();
                          Get.snackbar(
                            'Error',
                            'Wrong Credentials',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            icon: Icon(
                              Icons.error_outline_rounded,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          );
                          print(res.body);
                          //Get.to(() => NavScreen());
                        }
                      },
                    ),

                    //forgotpassword
                    // ignore: deprecated_member_use
                    // FlatButton.icon(
                    //   onPressed: () async {
                    //     // Get.to(() => NavScreen());
                    //     // Vibration.vibrate(duration: 10, amplitude: 180);
                    //     // Vibration.vibrate(pattern: [10, 10, 15, 15]);
                    //     // Get.close(2);

                    //     var res = await http.get(Uri.parse(
                    //         "$API/User/UserLogin?username=${loginUserID.text}&password=${loginUserPassword.text}"));
                    //     if (res.statusCode == 200) {
                    //       var loginData = jsonDecode(res.body);
                    //       print(loginData);
                    //       SharedPreferences prefs =
                    //           await SharedPreferences.getInstance();
                    //       prefs.setString(
                    //         "reg",
                    //         loginData['UserName'],
                    //       );
                    //       prefs.setString(
                    //         "UType",
                    //         loginData['UType'],
                    //       );
                    //       prefs.setString(
                    //         "FullName",
                    //         loginData['FullName'],
                    //       );
                    //       prefs.setString(
                    //         "Designation",
                    //         loginData['Designation'],
                    //       );
                    //       prefs.setString(
                    //         "Session",
                    //         loginData['Session'],
                    //       );
                    //       prefs.setString(
                    //         "ClassSection",
                    //         loginData['ClassSection'],
                    //       );

                    //       Get.to(() => NavScreen());
                    //     } else {
                    //       loginUserID.clear();
                    //       loginUserPassword.clear();
                    //       Get.snackbar(
                    //         'Error',
                    //         'Wrong Credentials',
                    //         backgroundColor: Colors.red,
                    //         colorText: Colors.white,
                    //         icon: Icon(
                    //           Icons.error_outline_rounded,
                    //           color: Colors.white,
                    //           size: 30.0,
                    //         ),
                    //       );
                    //       print(res.body);
                    //       //Get.to(() => NavScreen());
                    //     }
                    //   },
                    //   icon: const Icon(
                    //     Icons.login_rounded,
                    //     color: Colors.red,
                    //     size: 50,
                    //   ),
                    //   label: Text('Forgot'),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
