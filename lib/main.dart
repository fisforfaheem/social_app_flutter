import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/config/theme_config.dart';
import 'package:flutter_facebook_responsive_ui/screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/screens/walls/biit_wall.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

var screen;
void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.lightBlue[200]));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var id = pref.getString("userId");

  if (id == null) {
    screen = SignIn();
  } else
    screen = HomeScreen();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BIIT Social App',
      debugShowCheckedModeBanner: false,
      color: Colors.grey,
      theme: themeData(ThemeConfig.lightTheme),
      home: screen,
    );
  }
}

ThemeData themeData(ThemeData theme) {
  return theme.copyWith(
    textTheme: GoogleFonts.sourceSansProTextTheme(
      theme.textTheme,
    ),
  );
}
