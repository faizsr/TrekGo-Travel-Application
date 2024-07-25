// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/destination/presentation/views/home_page.dart';
import 'package:trekgo_project/src/feature/destination/presentation/views/search_page.dart';
import 'package:trekgo_project/src/feature/trip_planner/presentation/views/add_trip_page.dart';
import 'package:trekgo_project/src/feature/user/presentation/views/profile_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_drawer.dart';
import 'package:solar_icons/solar_icons.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    AddTripPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: indexChangeNotifier.value != 0,
      onPopInvoked: (didPop) {
        indexChangeNotifier.value = 0;
        return;
      },
      child: Scaffold(
        extendBody: true,
        key: scaffoldKey,
        drawer: CustomDrawer(scaffoldKey: scaffoldKey),
        body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: IndexedStack(
                key: ValueKey<int>(index),
                index: index,
                children: pages,
              ),
            );
          },
        ),

        // ===== Bottom navigation bar =====
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int newIndex, _) {
            return Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                      color: AppColors.darkTeal.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Gap(width: 1),
                        kIconButton(
                          context: context,
                          index: 0,
                          icon: SolarIconsOutline.homeAngle_2,
                          text: 'Home',
                        ),
                        kIconButton(
                          context: context,
                          index: 1,
                          icon: SolarIconsOutline.roundedMagnifier,
                          text: 'Search',
                        ),
                        kIconButton(
                          context: context,
                          index: 2,
                          icon: SolarIconsOutline.notebook,
                          text: 'Plan',
                        ),
                        kIconButton(
                          context: context,
                          index: 3,
                          icon: SolarIconsOutline.user,
                          text: 'Profile',
                        ),
                        const Gap(width: 1),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget kIconButton({
    required int index,
    required IconData icon,
    required String text,
    void Function()? onDoubleTap,
    required BuildContext context,
  }) {
    final selected = indexChangeNotifier.value == index;
    final iconColor =
        selected ? AppColors.white : AppColors.white.withOpacity(0.6);

    return MaterialButton(
      minWidth: 0,
      elevation: 0,
      padding: EdgeInsets.zero,
      onPressed: () {
        indexChangeNotifier.value = index;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: iconColor),
          const Gap(height: 4),
          Text(
            text,
            style: TextStyle(height: 1, fontSize: 11, color: iconColor),
          )
        ],
      ),
    );
  }
}
