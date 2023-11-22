import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trekmate_project/model/favorite.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/popular_places_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/recommended_screen.dart';
import 'package:trekmate_project/widgets/carousel_slider/popular_carousel_slider_copy.dart';
import 'package:trekmate_project/widgets/carousel_slider/recommended_slider.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/main_subtitle.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/top_bar_items.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/appbar_subtitles.dart';
import 'package:trekmate_project/widgets/carousel_slider/favorites_carousel_slider.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/choice_chips.dart';

class HomeScreenCopy extends StatefulWidget {
  final String? userId;
  final bool? isAdmin;
  final bool? isUser;
  const HomeScreenCopy({
    super.key,
    this.userId,
    this.isAdmin,
    this.isUser,
  });

  @override
  State<HomeScreenCopy> createState() => _HomeScreenCopyState();
}

class _HomeScreenCopyState extends State<HomeScreenCopy> {
  String? sortName;
  late Box<Favorites> favoriteBox;
  List<Favorites>? favoriteList;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorites');
    favoriteList = favoriteBox.values.toList();
    debugPrint('User id: ${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // physics: FixedExtentScrollPhysics(),
        child: Column(
          children: [
            // ===== Custom appbar =====
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.26,
                  decoration: const BoxDecoration(
                    color: Color(0xFFe5e6f6),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // ===== Appbar top items =====
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.06,
                        right: 25,
                        left: 25,
                        child: TopBarItems(placeLocation: sortName),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.24,
                        left: 25,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppbarSubtitles(
                              subtitleText: 'Hello Adam',
                              subtitleSize: 14,
                            ),
                            AppbarSubtitles(
                              subtitleText: 'Find Your Dream \nDestination',
                              subtitleSize: 23,
                              subtitleColor: Color(0xFF1285b9),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ===== Appbar choice chips =====
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.225,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ChoiceChipsWidget(
                      onSortNameChanged: (newSortName) {
                        setState(() {
                          sortName = newSortName;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            Column(
              children: [
                // ===== Popular places section =====
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MainSubtitles(
                          subtitleText: 'Popular',
                          viewAllPlaces: () {
                            nextScreen(
                              context,
                              PopularPlacesScreen(
                                sortName: sortName,
                                isAdmin: widget.isAdmin,
                                isUser: widget.isUser,
                              ),
                            );
                            debugPrint('Admin logged in ${widget.isAdmin}');
                            debugPrint('User logged in ${widget.isUser}');
                          }),
                      PopularCarouselSlider(
                        isAdmin: widget.isAdmin,
                        isUser: widget.isUser,
                        sortName: sortName,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // ===== Recommended places section =====
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MainSubtitles(
                        subtitleText: 'Recommended',
                        viewAllPlaces: () => nextScreen(
                          context,
                          RecommendedPlacesScreen(
                            isAdmin: widget.isAdmin,
                            isUser: widget.isUser,
                            sortName: sortName,
                          ),
                        ),
                      ),
                      RecommendedPlaceSlider(
                        isAdmin: widget.isAdmin,
                        isUser: widget.isUser,
                        sortName: sortName,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // ===== Favorite screen section =====
                favoriteList!.isNotEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            MainSubtitles(
                              subtitleText: 'Travel Wishlist',
                              viewAllPlaces: () => nextScreen(
                                  context,
                                  WishlistScreen(
                                    currentUserId: widget.userId,
                                  )),
                            ),
                            FavoritesCarouselSlider(
                                currentUserId: widget.userId),
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
            )
          ],
        ),
      ),
    );
  }
}

