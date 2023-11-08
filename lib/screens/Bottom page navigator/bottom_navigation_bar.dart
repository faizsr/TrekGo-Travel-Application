import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/Main%20Pages/add_favorite_screen.dart';
import 'package:trekmate_project/screens/Main%20Pages/home_screen_copy.dart';
import 'package:trekmate_project/screens/Main%20Pages/saved_places_screen.dart';
import 'package:trekmate_project/screens/Main%20Pages/profile_screen.dart';
import 'package:trekmate_project/screens/Main%20Pages/search_screen.dart';

class NavigationBottomBar extends StatefulWidget {
  const NavigationBottomBar({super.key});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int selectedIndex = 0;

  List pages = [
    const HomeScreenCopy(),
    const SearchScreen(),
    const AddFavoriteScreen(),
    const SavedPlacesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      extendBody: true,
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
                icon: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddFavoriteScreen(),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.height * 0.04,
                    decoration: const BoxDecoration(
                        color: Color(0xFF1285b9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(70),
                        )),
                    child: const Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.white,
                    ),
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
