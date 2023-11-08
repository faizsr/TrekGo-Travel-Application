import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/Main%20Pages/Sub%20pages/favorites_screen.dart';
import 'package:trekmate_project/screens/Main%20Pages/Sub%20pages/popular_places_screen.dart';
import 'package:trekmate_project/screens/Main%20Pages/Sub%20pages/recommended_screen.dart';
import 'package:trekmate_project/widgets/Carousel%20slider/popular_carousel_slider_copy.dart';
import 'package:trekmate_project/widgets/Carousel%20slider/recommended_slider.dart';
import 'package:trekmate_project/widgets/Home%20screen%20widgets/main_subtitle.dart';
import 'package:trekmate_project/widgets/Home%20screen%20widgets/top_bar_items.dart';
import 'package:trekmate_project/widgets/Main%20screens%20widgets/appbar_subtitles.dart';
import 'package:trekmate_project/widgets/Carousel%20slider/favorites_carousel_slider.dart';
import 'package:trekmate_project/widgets/choice%20chips/choice_chips.dart';

class HomeScreenCopy extends StatefulWidget {
  const HomeScreenCopy({super.key});

  @override
  State<HomeScreenCopy> createState() => _HomeScreenCopyState();
}

class _HomeScreenCopyState extends State<HomeScreenCopy> {
  String? sortName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Appbar
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
                      //Appbar Top items
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.06,
                        right: 25,
                        left: 25,
                        child: const TopBarItems(),
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

                //Appbar tab bars
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
                //Popular Section
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MainSubtitles(
                        subtitleText: 'Popular',
                        viewAllPlaces: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                PopularPlacesScreen(sortName: sortName),
                          ),
                        ),
                      ),
                      PopularCarouselSlider(sortName: sortName)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //Recommended Screen
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MainSubtitles(
                        subtitleText: 'Recommended',
                        viewAllPlaces: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                RecommendedPlacesScreen(sortName: sortName),
                          ),
                        ),
                      ),
                      RecommendedPlaceSlider(sortName: sortName),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Favorites screen
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      MainSubtitles(
                        subtitleText: 'Your Favorites',
                        viewAllPlaces: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ),
                        ),
                      ),
                      const FavoritesCarouselSlider(),
                    ],
                  ),
                ),
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
