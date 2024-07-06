import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/changer/model/wishlist.dart';
import 'package:trekgo_project/changer/model/saved.dart';
import 'package:trekgo_project/src/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/splash_screen.dart';
import 'package:trekgo_project/changer/provider/saved_provider.dart';
import 'package:trekgo_project/src/feature/user/presentation/controllers/user_controller.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  await Hive.initFlutter('hive_db');
  Hive.registerAdapter<Wishlist>(WishlistAdapter());
  Hive.registerAdapter(SavedAdapter());
  await Hive.openBox<Wishlist>('wishlists');
  await Hive.openBox<Saved>('saved');

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // statusBarColor: Color(0xFFe5e6f6),
      statusBarColor: Color(0xFFC0F8FE),
      // statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      // systemNavigationBarColor: Color(0xFFe5e6f6),
      systemNavigationBarColor: Color(0xFFF0F3F7),
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const MyApp(savedIds: []),
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SavedProvider(savedIds: widget.savedIds ?? []),
          ),
          ChangeNotifierProvider(
            create: (context) => di.getIt<AuthController>(),
          ),
          ChangeNotifierProvider(
            create: (context) => di.getIt<UserController>(),
          ),
        ],
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
}
