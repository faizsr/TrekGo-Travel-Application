import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/changer/model/saved.dart';
import 'package:trekgo_project/changer/model/wishlist.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/splash_screen.dart';
import 'package:trekgo_project/src/feature/destination/presentation/controllers/destination_controller.dart';
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
    SystemUiOverlayStyle(
      statusBarColor: AppColors.skyBlue,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.aquaBlue,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => di.getIt<AuthController>(),
          ),
          ChangeNotifierProvider(
            create: (context) => di.getIt<UserController>(),
          ),
          ChangeNotifierProvider(
            create: (context) => di.getIt<DestinationController>(),
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
            scaffoldBackgroundColor: AppColors.aquaBlue,
            splashFactory: NoSplash.splashFactory,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
