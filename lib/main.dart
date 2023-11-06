import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/firebase_options.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/Bottom%20page%20navigator/bottom_navigation_bar.dart';
import 'package:trekmate_project/screens/Main%20Pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isUserSignedIn = false;
  bool _isAdminSignedIn = false;

  @override
  void initState() {
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
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: const Color(0xFFf0f3f7),
        ),
        debugShowCheckedModeBanner: false,
        home: _isUserSignedIn
            ? const NavigationBottomBar()
            : _isAdminSignedIn
                ? const NavigationBottomBar()
                : const SplashScreen(),
      ),
    );
  }
}
