import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/edit_profile_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/settings_screen.dart';
import 'package:trekmate_project/screens/main_pages/saved_places_screen.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/appbar_subtitles.dart';
import 'package:trekmate_project/widgets/reusable_widgets/user_profile_listtile.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;
  final String? userProfilePic;
  final String? userFullname;
  final String? userGender;
  final String? username;
  final String? userEmail;
  const ProfileScreen({
    super.key,
    this.userId,
    this.userProfilePic,
    this.userFullname,
    this.userGender,
    this.username,
    this.userEmail,
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Background_gradient.png'),
              fit: BoxFit.cover),
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
                              margin: const EdgeInsets.only(top: 5),
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
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 5,
                ),
                child: Column(
                  children: [
                    // ===== Edit profile button =====
                    UserProfileListtile(
                        titleText: 'Edit Profile',
                        onTapIcon: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                userId: widget.userId,
                                image: userProfilePic ?? defaultImage,
                                fullName: userFullname,
                                mobileNumber: userMobileNumber,
                                email: userEmail,
                                gender: userGender,
                              ),
                            ),
                          );
                        }),
                    const Divider(
                      thickness: 0.8,
                      height: 10,
                      indent: 15,
                      endIndent: 15,
                    ),

                    // ===== Saved places button =====
                    UserProfileListtile(
                      titleText: 'Saved Places',
                      onTapIcon: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SavedPlacesScreen())),
                    ),
                    const Divider(
                      thickness: 0.5,
                      height: 10,
                      indent: 15,
                      endIndent: 15,
                    ),

                    // ===== Wishlist places button =====
                    UserProfileListtile(
                      titleText: 'Your Wishlists',
                      onTapIcon: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const WishlistScreen(),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      height: 10,
                      indent: 15,
                      endIndent: 15,
                    ),

                    // ===== Settings button =====
                    UserProfileListtile(
                      titleText: 'Settings',
                      onTapIcon: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      height: 10,
                      indent: 15,
                      endIndent: 15,
                    ),

                    // ===== Logout button =====
                    UserProfileListtile(
                      titleText: 'Logout',
                      onTapIcon: () {
                        authService.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const UserLoginScreen()),
                            (route) => false);
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
}
