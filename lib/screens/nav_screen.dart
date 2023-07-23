import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/screens/screens.dart';
import 'package:flutter_facebook_responsive_ui/screens/walls/walls.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CustomeNavbar extends StatefulWidget {
  final ind;
  const CustomeNavbar({Key? key, this.ind}) : super(key: key);

  @override
  _CustomeNavbarState createState() => _CustomeNavbarState();
}

class _CustomeNavbarState extends State<CustomeNavbar> {
  var type = '';
  var fullName = '';
  atStart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    type = pref.getString("UType")!;
    fullName = pref.getString("FullName")!;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    atStart();
  }

  @override
  Widget build(BuildContext context) {
    return type.toLowerCase() == 'e'
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: GNav(
              backgroundColor: Colors.green.withOpacity(.09),
              selectedIndex: widget.ind,
              rippleColor:
                  Colors.grey[300]!, // tab button ripple color when pressed
              hoverColor: Colors.grey[100]!, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 200,
              tabActiveBorder: Border.all(
                  color: Colors.green, width: 0.03), // tab button border
              tabBorder: Border.all(
                  color: Colors.green, width: 0.01), // tab button border
              curve: Curves.bounceInOut, // tab animation curves
              duration: Duration(milliseconds: 300), // tab animation duration
              // gap: 1, // the tab button gap between icon and text
              color: Colors.green[900], // unselected icon color
              activeColor: Colors.black, // selected icon and text color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              iconSize: 25, // tab button icon size

              tabShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
              ],
              tabBackgroundColor:
                  Colors.grey[100]!, // selected tab background color
              // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'BIIT Wall',
                ),
                GButton(
                  icon: Icons.group_outlined,
                  text: 'Session',
                ),
                GButton(
                  icon: Icons.book_outlined,
                  text: 'Diary ',
                ),
                GButton(
                  icon: Icons.more_horiz_outlined,
                  text: 'More',
                ),
              ],
              onTabChange: (i) {
                switch (i) {
                  case 0:
                    Get.offAll(() => HomeScreen());

                    break;
                  case 1:
                    // Get.offAll(() => HomeScreen());
                    Get.offAll(() => SessionWall());

                    break;

                  case 2:
                    //  Get.offAll(() => HomeScreen());
                    Get.offAll(() => PersonalDiary());
                    break;

                  case 3:
                    //Get.offAll(() => HomeScreen());
                    Get.offAll(() => MoreOptions());

                    break;

                  // default:
                }
              },
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                // BoxShadow(
                //   blurRadius: 20,
                //   color: Colors.black.withOpacity(.1),
                // )
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 60,
                  color: Colors.black.withOpacity(.20),
                  offset: Offset(0, 15),
                )
              ],
            ),
            child: GNav(
              backgroundColor: Colors.green.withOpacity(.09),
              selectedIndex: widget.ind,
              rippleColor:
                  Colors.grey[300]!, // tab button ripple color when pressed
              hoverColor: Colors.grey[100]!, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 200,
              tabActiveBorder: Border.all(
                  color: Colors.green, width: 0.03), // tab button border
              tabBorder: Border.all(
                  color: Colors.green, width: 0.01), // tab button border
              curve: Curves.bounceInOut, // tab animation curves
              // gap: 1, // the tab button gap between icon and text
              color: Colors.green[900], // unselected icon color
              activeColor: Colors.black, // selected icon and text color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16.5),
              duration: Duration(milliseconds: 800),
              iconSize: 25, // tab button icon size

              tabShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
              ],
              tabBackgroundColor:
                  Colors.grey[100]!, // selected tab background color
              // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'BIIT',
                ),
                GButton(
                  icon: Icons.group_outlined,
                  text: 'Session',
                ),
                GButton(
                  icon: Icons.groups_outlined,
                  text: 'Class Wall ',
                ),
                GButton(
                  icon: Icons.account_box,
                  text: 'Profile',
                  leading: CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                        'https://sooxt98.space/content/images/size/w100/2019/01/profile.png'),
                  ),
                ),
                GButton(
                  icon: Icons.more_horiz_outlined,
                  text: 'More',
                ),
                // GButton(
                //   icon: Icons.person_outlined,
                //   // text: 'Profile',
                // ),
                // GButton(
                //   icon: Icons.more_horiz_outlined,
                //   // text: 'More',
                // ),
              ],
              onTabChange: (i) {
                switch (i) {
                  case 0:
                    Get.offAll(() => HomeScreen());

                    break;
                  case 1:
                    Get.offAll(() => SessionWall());

                    break;
                  case 2:
                    Get.offAll(() => ClassWall());
                    break;

                  case 3:
                    Get.offAll(() => ProfilePage());
                    break;

                  case 4:
                    Get.offAll(() => MoreOptions());

                    break;
                  // case 5:
                  //   Get.offAll(ProfilePage());
                  //   break;
                  // case 6:
                  //   Get.offAll(MoreOptions());
                  //   break;
                  // default:
                }
              },
            ),
          );
  }
}



//old nav
// class NavScreen extends StatefulWidget {
//   @override
//   _NavScreenState createState() => _NavScreenState();
// }

// class _NavScreenState extends State<NavScreen> {
//   final List<Widget> _screens = [
//     HomeScreen(), //Main Home Screen
//     SessionPage(), //session Wall
//     new PersonalDiary(), //Personal Diary
//     GroupsList(), //Groups List
//     MoreOptions(),
//   ];
//   final List<IconData> _icons = const [
//     Icons.home_outlined,
//     MdiIcons.googleClassroom,
//     MdiIcons.accountCircleOutline,
//     MdiIcons.accountGroupOutline,
//     //MdiIcons.googleCirclesGroup, //disabling bcuz sir thinks it's weird.
//     // MdiIcons.bellOutline,
//     Icons.menu,
//   ];
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   init() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var id = prefs.getString(
//       "userId",
//     );
//     print("=====> $id");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: _icons.length,
//       child: Scaffold(
//         body: IndexedStack(
//           index: _selectedIndex,
//           children: _screens,
//         ),
//         bottomNavigationBar: Theme(
//           data: Theme.of(context).copyWith(
//             // sets the background color of the `BottomNavigationBar`
//             canvasColor: Theme.of(context).primaryColor,
//             // sets the active color of the `BottomNavigationBar` if `Brightness` is light
//             // ignore: deprecated_member_use
//             primaryColor: Theme.of(context).accentColor,
//             textTheme: Theme.of(context).textTheme.copyWith(
//                   caption: TextStyle(color: Colors.grey[500]),
//                 ),
//           ),
//           child: Container(
//             padding: const EdgeInsets.only(bottom: 12.0),
//             color: Colors.white70,
//             child: CustomTabBar(
//                 icons: _icons,
//                 selectedIndex: _selectedIndex,
//                 onTap: (index) async {
//                   //Vibration.vibrate(duration: 10, amplitude: 180);
//                   setState(() => _selectedIndex = index);
//                 }),
//           ),
//         ),
//       ),
//     );
//   }
// }
