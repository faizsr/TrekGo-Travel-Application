import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trekmate_project/firebase_options.dart';
import 'package:trekmate_project/model/favorite.dart';
import 'package:trekmate_project/model/saved.dart';
import 'package:trekmate_project/screens/main_pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter('hive_db');
  Hive.registerAdapter<Favorites>(FavoritesAdapter());
  Hive.registerAdapter(SavedAdapter());
  await Hive.openBox<Favorites>('favorites');
  await Hive.openBox<Saved>('saved');

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
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: const Color(0xFFf0f3f7),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
