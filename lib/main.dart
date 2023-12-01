import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:trekmate_project/firebase_options.dart';
import 'package:trekmate_project/model/wishlist.dart';
import 'package:trekmate_project/model/saved.dart';
import 'package:trekmate_project/screens/main_pages/splash_screen.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/provider/saved_provider.dart';

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

  List<String> savedIds = await loadSavedIds();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top,
  ]);

  runApp(
    MyApp(savedIds: savedIds),
  );
}

class MyApp extends StatefulWidget {
  final List<String>? savedIds;
  const MyApp({
    super.key,
    this.savedIds,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(
      const Color(0xFFe5e6f6),
    );
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ChangeNotifierProvider(
        create: (context) => SavedProvider(savedIds: widget.savedIds ?? []),
        child: MaterialApp(
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

Future<List<String>> loadSavedIds() async {
  Box<Saved> savedBox = Hive.box('saved');
  List<String> savedIds =
      savedBox.keys.map((dynamic key) => key.toString()).toList();
  return savedIds;
}
