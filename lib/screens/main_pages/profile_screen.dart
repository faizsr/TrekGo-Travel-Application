import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/edit_profile_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/settings_screen.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/appbar_subtitles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/user_profile_listtile.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;
  final void Function(int)? updateIndex;
  const ProfileScreen({
    super.key,
    this.userId,
    this.updateIndex,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  Stream<DocumentSnapshot>? userDataStream;

  @override
  void initState() {
    userDataStream = DatabaseService().getUserDetails(widget.userId ?? '');
    super.initState();
  }

  String? userFullname;
  String? userGender;
  String? userMobileNumber;
  String? userEmail;
  String? userProfilePic;

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0xFFc0f8fe));
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF0F3F7),
              Color(0xFFC0F8FE),
            ],
            stops: [0.25, 0.87],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),

            // ===== Profile photo =====
            StreamBuilder(
              stream: userDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userDataSnapshot =
                      snapshot.data?.data() as Map<String, dynamic>;
                  userFullname =
                      (userDataSnapshot['fullname'] as String).capitalise();
                  userGender = userDataSnapshot['gender'];
                  userMobileNumber = userDataSnapshot['mobile_number'];
                  userEmail = userDataSnapshot['email'];
                  userProfilePic = userDataSnapshot['profilePic'];
                  return Column(
                    children: [
                      Stack(
                        children: [
                          const Align(
                            child: Image(
                              image: AssetImage(
                                  'assets/images/profile_image_background.png'),
                            ),
                          ),
                          Align(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.005),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 2.5),
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    color: Color(0x1A000000),
                                  )
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 85,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(defaultImage),
                                foregroundImage: userProfilePic == null
                                    ? Image.asset(defaultImage).image
                                    : Image.network(userProfilePic ?? '').image,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      // ===== Name of the user =====
                      Text(
                        userFullname ?? '',
                        style: const TextStyle(
                          fontSize: 23.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // ===== Email of the user =====
                      Text(
                        userDataSnapshot['email'],
                        style: const TextStyle(
                            fontSize: 11.5,
                            color: Color(0x80000000),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),

            // ===== Bottom card =====
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 15,
                    spreadRadius: 1,
                    color: Color(0x0D000000),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: 15,
                  right: 5,
                ),
                child: Column(
                  children: [
                    // ===== Edit profile button =====
                    UserProfileListtile(
                      titleText: 'Edit Profile',
                      onTapIcon: () {
                        nextScreen(
                          context,
                          EditProfileScreen(
                            userId: widget.userId,
                            image: userProfilePic ?? defaultImage,
                            fullName: userFullname,
                            mobileNumber: userMobileNumber,
                            email: userEmail,
                            gender: userGender,
                          ),
                        );
                      },
                    ),
                    Divider(
                      thickness: MediaQuery.of(context).size.height * 0.0007,
                      height: MediaQuery.of(context).size.height * 0.015,
                      indent: 15,
                      endIndent: 15,
                    ),

                    // ===== Saved places button =====
                    UserProfileListtile(
                      titleText: 'Saved Places',
                      onTapIcon: () {
                        widget.updateIndex?.call(3);
                      },
                    ),
                    Divider(
                      thickness: MediaQuery.of(context).size.height * 0.0007,
                      height: MediaQuery.of(context).size.height * 0.015,
                      indent: 15,
                      endIndent: 15,
                    ),

                    // ===== Wishlist places button =====
                    UserProfileListtile(
                      titleText: 'Your Wishlists',
                      onTapIcon: () =>
                          nextScreen(context, const WishlistScreen()),
                    ),
                    Divider(
                      thickness: MediaQuery.of(context).size.height * 0.0007,
                      height: MediaQuery.of(context).size.height * 0.015,
                      indent: 15,
                      endIndent: 15,
                    ),

                    // ===== Settings button =====
                    UserProfileListtile(
                        titleText: 'Settings',
                        onTapIcon: () {
                          nextScreen(
                              context,
                              SettingsScreen(
                                userId: widget.userId,
                                userImage: userProfilePic ?? defaultImage,
                                userFullName: userFullname,
                                userMobileNumber: userMobileNumber,
                                userEmail: userEmail,
                                userGender: userGender,
                              ));
                        }),
                    Divider(
                      thickness: MediaQuery.of(context).size.height * 0.0007,
                      height: MediaQuery.of(context).size.height * 0.015,
                      indent: 15,
                      endIndent: 15,
                    ),

                    // ===== Logout button =====
                    UserProfileListtile(
                      titleText: 'Logout',
                      onTapIcon: () {
                        authService.signOut();
                        nextScreenRemoveUntil(context, const UserLoginScreen());
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    resetStatusBarColor();
  }
}
