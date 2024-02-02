import 'package:animations/animations.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/widgets/bottomnav_and_drawer/navigation_drawer.dart';
import 'package:trekgo_project/screens/main_pages/add_wishlist_screen.dart';
import 'package:trekgo_project/screens/main_pages/home_screen/home_screen.dart';
import 'package:trekgo_project/screens/main_pages/saved_places_screen/saved_places_screen.dart';
import 'package:trekgo_project/screens/main_pages/profile_screen/profile_screen.dart';
import 'package:trekgo_project/screens/main_pages/search_screen.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class NavigationBottomBar extends StatefulWidget {
  final String? userId;
  final bool? isAdmin;
  final bool? isUser;
  final int? index;
  final String? username;
  final String? useremail;
  final String? usermobile;
  final String? usergender;
  final String? userprofile;
  const NavigationBottomBar({
    super.key,
    this.userId,
    this.isAdmin,
    this.isUser,
    this.index,
    this.username,
    this.useremail,
    this.usermobile,
    this.usergender,
    this.userprofile,
  });

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      HomeScreen(
        userId: widget.userId,
        isAdmin: widget.isAdmin,
        isUser: widget.isUser,
      ),
      SearchScreen(
        userId: widget.userId,
        isAdmin: widget.isAdmin,
        isUser: widget.isUser,
      ),
      AddWishlistScreen(
        userId: widget.userId,
      ),
      SavedPlacesScreen(
        userId: widget.userId ?? '',
        isAdmin: widget.isAdmin,
        isUser: widget.isUser,
      ),
      ProfileScreen(
        userId: widget.userId,
      ),
    ];
    debugPrint('Admin logged in ${widget.isAdmin}');
    debugPrint('User logged in ${widget.isUser}');
    debugPrint('User id on navigation : ${widget.userId}');
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
        key: scaffoldKey,
        drawer: NavigationDrawerr(
          userId: widget.userId ?? '',
          username: widget.username,
          useremail: widget.useremail,
          usergender: widget.usergender,
          usermobile: widget.usermobile,
          userprofile: widget.userprofile,
          scaffoldKey: scaffoldKey,
        ),
        // ===== Body =====
        body: ValueListenableBuilder(
            valueListenable: indexChangeNotifier,
            builder: (context, int index, child) {
              return PageTransitionSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) =>
                        FadeTransition(
                  opacity: primaryAnimation,
                  child: child,
                ),
                child: pages[index],
              );
            }),
        extendBody: true,

        // ===== Bottom navigation bar =====
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: indexChangeNotifier,
            builder: (context, int newIndex, _) {
              return Container(
                margin: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BottomNavigationBar(
                    currentIndex: newIndex,
                    onTap: (index) {
                      indexChangeNotifier.value = index;
                    },
                    backgroundColor: const Color(0xFFe5e6f6),
                    landscapeLayout:
                        BottomNavigationBarLandscapeLayout.centered,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    unselectedItemColor: const Color(0xFF1285b9),
                    selectedItemColor: Colors.black,
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.home,
                          size: 28,
                        ),
                        label: '',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.search,
                          size: 28,
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        activeIcon: Container(
                          width: MediaQuery.of(context).size.width * 0.09,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(70),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 25,
                            color: Color(0xFF1285b9),
                          ),
                        ),
                        icon: Container(
                          width: MediaQuery.of(context).size.width * 0.09,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1285b9),
                            borderRadius: BorderRadius.all(
                              Radius.circular(70),
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        label: '',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.bookmark,
                          size: 28,
                        ),
                        label: '',
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(
                          FeatherIcons.user,
                          size: 28,
                        ),
                        label: '',
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
