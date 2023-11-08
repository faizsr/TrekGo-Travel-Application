import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/Bottom%20page%20navigator/bottom_navigation_bar.dart';
import 'package:trekmate_project/screens/User/user_login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isUserSignedIn = false;
  bool _isAdminSignedIn = false;
  // @override
  // void initState() {
  //   gotoLogin();
  //   super.initState();
  // }

  @override
  void initState() {
    checkLoginStatus();
    getUserLoggedInStatus();
    getAdminLoggedInStatus();
    super.initState();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isUserSignedIn = value;
        });
      }
    });
  }

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Image.asset(appNameWithLogo),
        ),
      ),
    );
  }

  Future<void> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      _isUserSignedIn
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NavigationBottomBar(),
              ),
            )
          : _isAdminSignedIn
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NavigationBottomBar(),
                  ),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserLoginScreen(),
                  ),
                );
    }
  }
}
