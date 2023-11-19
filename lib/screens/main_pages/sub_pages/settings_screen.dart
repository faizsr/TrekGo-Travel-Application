import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/admin/add_place_screen.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/listtile_item.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';

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
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: const PlaceScreenAppbar(
          title: 'Settings',
          isLocationEnable: false,
        ),
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
                        nextScreen(context, const AddPlaceScreen());
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
                onTap: () =>
                    nextScreenRemoveUntil(context, const UserLoginScreen()),
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
