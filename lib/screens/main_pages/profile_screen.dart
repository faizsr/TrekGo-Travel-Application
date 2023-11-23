import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/edit_profile_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/settings_screen.dart';
import 'package:trekmate_project/screens/main_pages/saved_places_screen.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/reusable_widgets/user_profile_listtile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 90,
          ),

          // ===== Profile photo =====
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 18,
                  spreadRadius: 2,
                  color: Color(0x1A000000),
                )
              ],
            ),
            child: CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage(userProfile),
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          // ===== Name of the user =====
          const Text(
            'Adam Bekh',
            style: TextStyle(
              fontSize: 23.5,
              fontWeight: FontWeight.w600,
            ),
          ),

          // ===== Email of the user =====
          const Text(
            'adambekh@gmail.com',
            style: TextStyle(
                fontSize: 11.5,
                color: Color(0x80000000),
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 50,
          ),

          // ===== Bottom card =====
          Container(
            height: MediaQuery.of(context).size.height * 0.525,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 15,
                right: 5,
              ),
              child: Column(
                children: [

                  // ===== Edit profile button =====
                  UserProfileListtile(
                    titleText: 'Edit Profile',
                    onTapIcon: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    ),
                  ),
                  const Divider(
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
    );
  }
}
