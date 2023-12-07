// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/widgets/bottomnav_and_drawer/bottom_navigation_bar.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/widgets/reusable_widgets/alerts_and_navigates.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isUserSignedIn = false;
  bool _isAdminSignedIn = false;

  @override
  void initState() {
    checkLoginStatus();
    getUserLoggedInStatus();
    getAdminLoggedInStatus();
    super.initState();
    debugPrint('User id on splash ${FirebaseAuth.instance.currentUser?.uid}');
  }

  // ===== Checking if user login =====
  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isUserSignedIn = value;
        });
      }
    });
  }

  // ===== Checking if admin login =====
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
      // ===== Body =====
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFE5E6F6),
          // image: DecorationImage(
          //   image: AssetImage(backgroundImage),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Image.asset(
            appLogo,
            width: 230,
          ),
        ),
      ),
    );
  }

  // ===== Function for navigating based on roles =====
  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(microseconds: 500));

    if (mounted) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      _isUserSignedIn
          ? nextScreenReplace(
              context,
              NavigationBottomBar(
                isUser: _isUserSignedIn,
                isAdmin: _isAdminSignedIn,
                userId: FirebaseAuth.instance.currentUser!.uid,
                username: userSnapshot['fullname'],
                useremail: userSnapshot['email'],
                usergender: userSnapshot['gender'],
                usermobile: userSnapshot['mobile_number'],
                userprofile: userSnapshot['profilePic'] ?? '',
              ),
            )
          : _isAdminSignedIn
              ? nextScreenReplace(
                  context,
                  NavigationBottomBar(
                    isAdmin: _isAdminSignedIn,
                    isUser: _isUserSignedIn,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    username: userSnapshot['fullname'],
                    useremail: userSnapshot['email'],
                    usergender: userSnapshot['gender'],
                    usermobile: userSnapshot['mobile_number'],
                    userprofile: userSnapshot['profilePic'] ?? '',
                  ),
                )
              : nextScreenReplace(context, const UserLoginScreen());
    }
  }
}
