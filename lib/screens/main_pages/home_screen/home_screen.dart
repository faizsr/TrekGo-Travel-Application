import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trekmate_project/model/wishlist.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/popular_places_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/recommended_screen.dart';
import 'package:trekmate_project/widgets/carousel_slider/popular_carousel_slider.dart';
import 'package:trekmate_project/widgets/carousel_slider/recommended_slider.dart';
import 'package:trekmate_project/widgets/carousel_slider/wishlist_carousel_slider.dart';
import 'package:trekmate_project/screens/main_pages/home_screen/widgets/top_bar_items.dart';
import 'package:trekmate_project/screens/main_pages/home_screen/widgets/appbar_subtitles.dart';
import 'package:trekmate_project/widgets/chips_and_drop_downs/choice_chips.dart';
import 'package:trekmate_project/widgets/reusable_widgets/alerts_and_navigates.dart';

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
    setStatusBarColor(const Color(0xFFe5e6f6));
    var mediaHeight = MediaQuery.of(context).size.height;
    var mediaWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
        valueListenable: wishlistBox.listenable(),
        builder: (context, Box<Wishlist> wishlistBox, snapshot) {
          var wishlist = wishlistBox.values
              .where((wishlists) => wishlists.userId == widget.userId)
              .toList();
          return Scaffold(
            // drawer: const NavigationDrawerr(),
            body: SingleChildScrollView(
              // physics: FixedExtentScrollPhysics(),
              child: Column(
                children: [
                  // ===== Custom appbar =====
                  SizedBox(
                    width: mediaWidth,
                    height: mediaHeight * 0.28,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          padding: EdgeInsets.fromLTRB(
                              25, mediaHeight * 0.02, 20, 0),
                          decoration: const BoxDecoration(
                            color: Color(0xFFe5e6f6),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(60),
                            ),
                          ),
                          child: Column(
                            children: [
                              // ===== Appbar top items =====
                              TopBarItems(
                                userId: widget.userId,
                                placeLocation: sortName,
                                scaffoldContext: context,
                                updateIndex: widget.updateIndex,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppbarSubtitlesStream(
                                    userId: widget.userId,
                                    subtitleSize: 14,
                                  ),
                                  const AppbarSubtitles(
                                    subtitleText:
                                        'Find Your Dream \nDestination',
                                    subtitleSize: 23,
                                    subtitleColor: Color(0xFF1285b9),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.208,
                          child: ChoiceChipsWidget(
                            onSortNameChanged: (newSortName) {
                              setState(() {
                                sortName = newSortName;
                              });
                            },
                          ),
                        ),
                        // ===== Appbar choice chips =====
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 0,
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
                                      sortName: sortName ?? 'View All',
                                      isAdmin: widget.isAdmin,
                                      isUser: widget.isUser,
                                    ),
                                  );
                                  debugPrint(
                                      'Admin logged in ${widget.isAdmin}');
                                  debugPrint('User logged in ${widget.isUser}');
                                }),
                            PopularCarouselSlider(
                              userId: widget.userId,
                              isAdmin: widget.isAdmin,
                              isUser: widget.isUser,
                              sortName: sortName ?? 'View All',
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
                                  sortName: sortName ?? 'View All',
                                ),
                              ),
                            ),
                            RecommendedPlaceSlider(
                              userId: widget.userId,
                              isAdmin: widget.isAdmin,
                              isUser: widget.isUser,
                              sortName: sortName ?? 'View All',
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
        });
  }
}
