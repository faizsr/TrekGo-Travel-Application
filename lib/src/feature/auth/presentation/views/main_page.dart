// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/screens/main_pages/add_wishlist_screen.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/destination/presentation/views/home_page.dart';
import 'package:trekgo_project/changer/screens/main_pages/saved_places_screen/saved_places_screen.dart';
import 'package:trekgo_project/changer/screens/main_pages/search_screen.dart';
import 'package:trekgo_project/src/feature/user/presentation/views/profile_screen/profile_screen.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/custom_drawer.dart';
import 'package:solar_icons/solar_icons.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List pages = [];

  @override
  void initState() {
    super.initState();
    pages = const [
      HomePage(),
      SearchScreen(),
      AddWishlistScreen(),
      SavedPlacesScreen(),
      ProfileScreen(),
    ];
  }

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
            return PageTransitionSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                return FadeTransition(
                  opacity: primaryAnimation,
                  child: child,
                );
              },
              child: pages[index],
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
                        // addButton(
                        //   context: context,
                        //   index: 2,
                        //   icon: Icons.add_rounded,
                        // ),
                        kIconButton(
                          context: context,
                          index: 3,
                          icon: SolarIconsOutline.bookmark,
                          text: 'Saved',
                        ),
                        kIconButton(
                          context: context,
                          index: 4,
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
      onPressed: () {
        indexChangeNotifier.value = index;
      },
      minWidth: 0,
      elevation: 0,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: iconColor,
          ),
          const Gap(height: 4),
          Text(
            text,
            style: TextStyle(
              height: 1,
              fontSize: 11,
              color: iconColor,
            ),
          )
        ],
      ),
    );
  }

  Widget addButton({
    required int index,
    required IconData icon,
    void Function()? onDoubleTap,
    required BuildContext context,
  }) {
    final selected = indexChangeNotifier.value == index;
    final iconColor = selected ? AppColors.white : AppColors.darkTeal;
    final bgColor = selected ? AppColors.darkTeal : AppColors.white;

    return MaterialButton(
      onPressed: () {
        indexChangeNotifier.value = index;
      },
      color: bgColor,
      shape: const CircleBorder(),
      minWidth: 0,
      elevation: 0,
      padding: const EdgeInsets.all(6),
      child: Icon(
        icon,
        size: 26,
        color: iconColor,
      ),
    );
  }
}
