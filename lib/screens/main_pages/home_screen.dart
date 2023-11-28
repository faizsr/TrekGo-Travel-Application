import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trekmate_project/model/wishlist.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/popular_places_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/recommended_screen.dart';
import 'package:trekmate_project/widgets/carousel_slider/popular_carousel_slider_copy.dart';
import 'package:trekmate_project/widgets/carousel_slider/recommended_slider.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/main_subtitle.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/top_bar_items.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/appbar_subtitles.dart';
import 'package:trekmate_project/widgets/carousel_slider/wishlist_carousel_slider.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/choice_chips.dart';

class HomeScreen extends StatefulWidget {
  final String? userId;
  final bool? isAdmin;
  final bool? isUser;
  final String? userFullname;
  final void Function(int)? updateIndex;

  const HomeScreen({
    super.key,
    this.userId,
    this.isAdmin,
    this.isUser,
    this.userFullname,
    this.updateIndex,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? sortName;
  late Box<Wishlist> wishlistBox;
  List<Wishlist>? wishlistList;

  @override
  void initState() {
    super.initState();
    wishlistBox = Hive.box('wishlists');
    wishlistList = wishlistBox.values.toList();
    debugPrint('User id on home: ${widget.userId}');
    if (wishlistList!.isNotEmpty) {
      debugPrint('not empty');
      debugPrint('Data in the list ${wishlistList!.length}');
    } else {
      debugPrint('empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    var wishlist = wishlistList
            ?.where((wishlists) => wishlists.userId == widget.userId)
            .toList() ??
        [];

    wishlist.isNotEmpty
        ? debugPrint('Contains data ${wishlist.length}')
        : debugPrint('No data ${wishlist.length}');
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
                  height: MediaQuery.of(context).size.height * 0.25,
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
                        top: MediaQuery.of(context).size.width * 0.04,
                        right: 25,
                        left: 25,
                        child: TopBarItems(
                          userId: widget.userId,
                          placeLocation: sortName,
                          updateIndex: widget.updateIndex,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.22,
                        left: 25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppbarSubtitlesStream(
                              userId: widget.userId,
                              subtitleSize: 14,
                            ),
                            const AppbarSubtitles(
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
                  top: MediaQuery.of(context).size.height * 0.204,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.09,
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
                                userId: widget.userId,
                                sortName: sortName,
                                isAdmin: widget.isAdmin,
                                isUser: widget.isUser,
                              ),
                            );
                            debugPrint('Admin logged in ${widget.isAdmin}');
                            debugPrint('User logged in ${widget.isUser}');
                          }),
                      PopularCarouselSlider(
                        userId: widget.userId,
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
                            userId: widget.userId,
                            isAdmin: widget.isAdmin,
                            isUser: widget.isUser,
                            sortName: sortName,
                          ),
                        ),
                      ),
                      RecommendedPlaceSlider(
                        userId: widget.userId,
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

                // ===== Wishlist screen section =====
                wishlist.isNotEmpty
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            MainSubtitles(
                                subtitleText: 'Travel Wishlist',
                                viewAllPlaces: () {
                                  nextScreen(
                                    context,
                                    WishlistScreen(
                                      currentUserId: widget.userId,
                                    ),
                                  );
                                }),
                            WishlistCarouselSlider(
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
