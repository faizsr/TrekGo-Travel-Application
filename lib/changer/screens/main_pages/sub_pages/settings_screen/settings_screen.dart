import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/changer/helper/helper_functions.dart';
import 'package:trekgo_project/src/feature/admin/presentation/views/add_place_page.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/edit_profile_screen.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/settings_screen/widgets/widgets.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/settings_screen/sub_pages/about_us.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/settings_screen/sub_pages/privacy_policies.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/settings_screen/sub_pages/terms_and_conditions.dart';
import 'package:trekgo_project/changer/service/auth_service.dart';
// import 'package:trekgo_project/changer/service/database_service.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/password_reset_page.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/list/list_page_appbar.dart';

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
  Stream<DocumentSnapshot>? userDataStream;

  bool _isAdminSignedIn = false;

  @override
  void initState() {
    getAdminLoggedInStatus();
    // userDataStream = DatabaseService().getUserDetails(widget.userId ?? '');
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
        preferredSize: MediaQuery.of(context).size * 0.09,
        child: const CustomAppbar(
          title: 'Settings',
          // isLocationEnable: false,
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
                StreamBuilder(
                  stream: userDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final userDataSnapshot =
                          snapshot.data?.data() as Map<String, dynamic>;
                      return ListtileItem(
                        listtileText: 'Edit Profile',
                        onTap: () => nextScreen(
                            context,
                            EditProfileScreen(
                              userId: widget.userId,
                              image: userDataSnapshot['profilePic'],
                              fullName: userDataSnapshot['fullname'],
                              mobileNumber: userDataSnapshot['mobile_number'],
                              email: userDataSnapshot['email'],
                              gender: userDataSnapshot['gender'],
                              snackBarBtmPadding: 20,
                            )),
                      );
                    }
                    return Container();
                  },
                ),
                ListtileItem(
                  listtileText: 'Reset Password',
                  onTap: () {
                    nextScreen(
                        context,
                        PasswordResetPage(
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
                          nextScreen(context, const AddPlacePage());
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
                ),
                ListtileItem(
                  onTap: () {
                    nextScreen(context, const AboutUs());
                  },
                  listtileText: 'About Us',
                )
              ],
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
            ),

            //Social links
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'FOLLOW OUR SOCIALS',
                    style: TextStyle(
                      fontSize: 12,
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
                        size: 14,
                        color: Color(0x33000000),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FeatherIcons.twitter,
                        color: Color(0x33000000),
                        size: 14,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FeatherIcons.facebook,
                        size: 14,
                        color: Color(0x33000000),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FeatherIcons.linkedin,
                        size: 14,
                        color: Color(0x33000000),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'v2.0.1',
                    style: TextStyle(
                        color: Color(0x1A000000),
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
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
