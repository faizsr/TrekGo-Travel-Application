import 'package:animations/animations.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/bottomnav_and_drawer/navigation_drawer.dart';
import 'package:trekmate_project/screens/main_pages/add_wishlist_screen.dart';
import 'package:trekmate_project/screens/main_pages/home_screen.dart';
import 'package:trekmate_project/screens/main_pages/saved_places_screen.dart';
import 'package:trekmate_project/screens/main_pages/profile_screen.dart';
import 'package:trekmate_project/screens/main_pages/search_screen.dart';

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
    required this.username,
    required this.useremail,
    required this.usermobile,
    required this.usergender,
    required this.userprofile
  });

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int selectedIndex = 0;

  List pages = [];

  void onUpdateIndex(int newIindex) {
    setState(() {
      selectedIndex = newIindex;
    });
    debugPrint('index on nav: $selectedIndex');
  }

  @override
  void initState() {
    super.initState();
    pages = [
      HomeScreen(
        userId: widget.userId,
        isAdmin: widget.isAdmin,
        isUser: widget.isUser,
        updateIndex: onUpdateIndex,
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
        updateIndex: onUpdateIndex,
      ),
    ];
    debugPrint('Admin logged in ${widget.isAdmin}');
    debugPrint('User logged in ${widget.isUser}');
    debugPrint('User id on navigation : ${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerr(
        userId: widget.userId ?? '',
        updateIndex: onUpdateIndex,
        username: widget.username,
        useremail: widget.useremail,
        usergender: widget.usergender,
        usermobile: widget.usermobile,
        userprofile: widget.userprofile,
      ),
      // ===== Body =====
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeTransition(
          opacity: primaryAnimation,
          child: child,
        ),
        child: pages[selectedIndex],
      ),
      extendBody: true,

      // ===== Bottom navigation bar =====
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFFe5e6f6),
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (index) => setState(() {
              selectedIndex = index;
            }),
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
      ),
    );
  }
}
