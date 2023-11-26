import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/main_pages/add_wishlist_screen.dart';
import 'package:trekmate_project/screens/main_pages/home_screen.dart';
import 'package:trekmate_project/screens/main_pages/saved_places_screen.dart';
import 'package:trekmate_project/screens/main_pages/profile_screen.dart';
import 'package:trekmate_project/screens/main_pages/search_screen.dart';

class NavigationBottomBar extends StatefulWidget {
  final String? userId;
  final bool? isAdmin;
  final bool? isUser;
  // final String? userProfilePic;
  // final String? userFullname;
  // final String? userGender;
  // final String? userEmail;
  const NavigationBottomBar({
    super.key,
    this.userId,
    this.isAdmin,
    this.isUser,
    // this.userProfilePic,
    // this.userFullname,
    // this.userGender,
    // this.userEmail,
  });

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int selectedIndex = 0;

  List pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      HomeScreen(
        userId: widget.userId,
        isAdmin: widget.isAdmin,
        isUser: widget.isUser,
        // userFullname: widget.userFullname,

      ),
      SearchScreen(
        isAdmin: widget.isAdmin,
        isUser: widget.isUser,
      ),
      AddWishlistScreen(
        userId: widget.userId,
      ),
      const SavedPlacesScreen(),
      ProfileScreen(
        userId: widget.userId,
        // userEmail: widget.userEmail,
        // userFullname: widget.userFullname,
        // userProfilePic: widget.userProfilePic,
        // userGender: widget.userGender,
      ),
    ];
    debugPrint('Admin logged in ${widget.isAdmin}');
    debugPrint('User logged in ${widget.isUser}');
    debugPrint('User id on navigation : ${widget.userId}');

    debugPrint('======= User Details =======');
    // debugPrint('Full name ${widget.userFullname}');
    // debugPrint('Email ${widget.userEmail}');
    // debugPrint('profile picture: ${widget.userProfilePic}');
    // debugPrint('Gender : ${widget.userGender}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Body =====
      body: pages[selectedIndex],
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
