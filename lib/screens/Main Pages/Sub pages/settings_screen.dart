import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/Admin/add_place_screen.dart';
import 'package:trekmate_project/screens/User/user_login_screen.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/listtile_item.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/section_titles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isAdminSignedIn = false;

  @override
  void initState() {
    getAdminLoggedInStatus();
    super.initState();
  }

  // ===== Checking if its admin =====
  getAdminLoggedInStatus() async {
    await HelperFunctions.getAdminLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isAdminSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Settings',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: const Color(0xFFe5e6f6),
      ),

      // ===== Body =====
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== App logo =====
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Image.asset(appName),
                ),
              ),

              // ===== General Section =====
              const SectionTitles(titleText: 'GENERAL'),
              const ListtileItem(listtileText: 'Edit Profile'),
              const ListtileItem(listtileText: 'Reset Password'),
              _isAdminSignedIn
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddPlaceScreen(),
                          ),
                        );
                      },
                      child:
                          const ListtileItem(listtileText: 'Add Destination'),
                    )
                  : const SizedBox(),

              // //Theme section
              // const SectionTitles(titleText: 'THEME'),
              // const ListtileItem(
              //   listtileText: 'Dark Theme',
              // ),

              // ===== Logout section
              const SectionTitles(titleText: 'LOGOUT'),
              ListtileItem(
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const UserLoginScreen(),
                    ),
                    (route) => false),
                listtileText: 'Logout',
              )
            ],
          ),

          //Social links
          Positioned(
            bottom: 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FOLLOW OUR SOCIALS',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0x33000000),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FeatherIcons.instagram,
                        size: 17,
                        color: Color(0x33000000),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FeatherIcons.twitter,
                        color: Color(0x33000000),
                        size: 17,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FeatherIcons.facebook,
                        size: 17,
                        color: Color(0x33000000),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FeatherIcons.linkedin,
                        size: 17,
                        color: Color(0x33000000),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
