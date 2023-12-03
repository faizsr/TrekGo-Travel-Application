import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/admin/add_place_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/edit_profile_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/terms_and_policy/privacy_policies.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/terms_and_policy/terms_and_conditions.dart';
import 'package:trekmate_project/screens/user/forgot_password_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/listtile_item.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';

class SettingsScreen extends StatefulWidget {
  final String? userId;
  final String? userImage;
  final String? userFullName;
  final String? userGender;
  final String? userMobileNumber;
  final String? userEmail;
  const SettingsScreen({
    super.key,
    this.userId,
    this.userImage,
    this.userFullName,
    this.userGender,
    this.userMobileNumber,
    this.userEmail,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthService authService = AuthService();

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
    setStatusBarColor(const Color(0XFFe5e6f6));

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
      body: SingleChildScrollView(
        child: Column(
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
                    width: MediaQuery.of(context).size.width * 2,
                    child: Image.asset(appName),
                  ),
                ),

                // ===== General Section =====
                const SectionTitles(titleText: 'GENERAL'),
                ListtileItem(
                  listtileText: 'Edit Profile',
                  onTap: () => nextScreen(
                      context,
                      EditProfileScreen(
                        userId: widget.userId,
                        image: widget.userImage,
                        fullName: widget.userFullName,
                        mobileNumber: widget.userMobileNumber,
                        email: widget.userEmail,
                        gender: widget.userGender,
                      )),
                ),
                ListtileItem(
                  listtileText: 'Reset Password',
                  onTap: () {
                    nextScreen(
                        context,
                        ForgotPasswordScreen(
                          resetText: 'Reset Password?',
                          backToLoginTxt: 'Done',
                          userEmail: widget.userEmail,
                          noBackToLogin: true,
                          adjustHeight: true,
                        ));
                  },
                ),
                _isAdminSignedIn
                    ? GestureDetector(
                        onTap: () {
                          nextScreen(context, const AddPlaceScreen());
                        },
                        child:
                            const ListtileItem(listtileText: 'Add Destination'),
                      )
                    : const SizedBox(),

                // ===== Logout section
                const SectionTitles(titleText: 'About'),
                ListtileItem(
                  onTap: () {
                    nextScreen(context, const TermsAndConditions());
                  },
                  listtileText: 'Terms & Conditions',
                ),
                ListtileItem(
                  onTap: () {
                    nextScreen(context, const PrivacyPolicy());
                  },
                  listtileText: 'Privacy policy',
                )
              ],
            ),

            //Social links
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.24),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    setStatusBarColor(const Color(0xFFc0f8fe));
  }
}
