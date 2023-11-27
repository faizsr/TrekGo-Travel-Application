import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trekmate_project/firebase_options.dart';
import 'package:trekmate_project/model/wishlist.dart';
import 'package:trekmate_project/model/saved.dart';
import 'package:trekmate_project/screens/main_pages/splash_screen.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter('hive_db');
  Hive.registerAdapter<Wishlist>(WishlistAdapter());
  Hive.registerAdapter(SavedAdapter());
  await Hive.openBox<Wishlist>('wishlists');
  await Hive.openBox<Saved>('saved');

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top,
  ]);

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
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(
      const Color(0xFFe5e6f6),
    );
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: SafeArea(child: child!),
        );
      },
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFf0f3f7),
        splashFactory: NoSplash.splashFactory,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    resetStatusBarColor();
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
