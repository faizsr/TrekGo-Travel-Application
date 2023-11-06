import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/favorite_card.dart';

class FavoritesCarouselSlider extends StatefulWidget {
  const FavoritesCarouselSlider({super.key});

  @override
  State<FavoritesCarouselSlider> createState() =>
      _FavoritesCarouselSliderState();
}

class _FavoritesCarouselSliderState extends State<FavoritesCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.3,
      child: CarouselSlider(
        items: [
          FavoritesCard(favoritesCardImage: cubbonPark),
          FavoritesCard(favoritesCardImage: maharajaPalace),
          FavoritesCard(favoritesCardImage: munnar),
          FavoritesCard(favoritesCardImage: varkala),
          FavoritesCard(favoritesCardImage: athirapally),
        ],
        options: CarouselOptions(
          scrollPhysics: const BouncingScrollPhysics(),
          // viewportFraction: 1.0,
          pauseAutoPlayInFiniteScroll: true,
          // height: MediaQuery.of(context).size.height / 2.95,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
