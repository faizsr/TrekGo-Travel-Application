// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/screens/main_pages/add_wishlist_screen.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/destination/presentation/views/home_screen.dart';
import 'package:trekgo_project/changer/screens/main_pages/saved_places_screen/saved_places_screen.dart';
import 'package:trekgo_project/changer/screens/main_pages/search_screen.dart';
import 'package:trekgo_project/src/feature/user/presentation/views/profile_screen/profile_screen.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/navigation_drawer.dart';

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
      HomeScreen(),
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
        drawer: NavigationDrawerr(scaffoldKey: scaffoldKey),
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
              margin: const EdgeInsets.all(15),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    decoration: BoxDecoration(
                      // color: AppColors.lightBlue.withOpacity(0.7),
                      color: const Color(0xFFe5e6f6),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Gap(width: 1),
                        kIconbutton(
                          context: context,
                          index: 0,
                          icon: FeatherIcons.home,
                        ),
                        kIconbutton(
                          context: context,
                          index: 1,
                          icon: FeatherIcons.search,
                        ),
                        kIconbutton(
                            context: context,
                            index: 2,
                            icon: CupertinoIcons.add,
                            isAdd: true),
                        kIconbutton(
                          context: context,
                          index: 3,
                          icon: FeatherIcons.bookmark,
                        ),
                        kIconbutton(
                          context: context,
                          index: 4,
                          icon: FeatherIcons.user,
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

  Widget kIconbutton({
    required int index,
    required IconData icon,
    bool isAdd = false,
    void Function()? onDoubleTap,
    required BuildContext context,
  }) {
    final selected = indexChangeNotifier.value == index;
    final bgColor = selected ? Colors.white : AppColors.darkTeal;
    final iconColor = selected
        ? isAdd
            ? AppColors.black
            : AppColors.black
        : isAdd
            ? AppColors.white
            : AppColors.darkTeal;

    return MaterialButton(
      onPressed: () {
        indexChangeNotifier.value = index;
      },
      color: isAdd ? bgColor : null,
      minWidth: 0,
      elevation: 0,
      padding: EdgeInsets.all(isAdd ? 8 : 0),
      shape: isAdd ? const CircleBorder() : null,
      child: Icon(
        icon,
        size: isAdd ? 20 : 25,
        color: iconColor,
      ),
    );
  }
}
