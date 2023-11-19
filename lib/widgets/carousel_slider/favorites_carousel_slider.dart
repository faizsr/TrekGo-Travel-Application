import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trekmate_project/model/favorite.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_place_detail.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/reusable_widgets/favorite_card.dart';

class FavoritesCarouselSlider extends StatefulWidget {
  const FavoritesCarouselSlider({super.key});

  @override
  State<FavoritesCarouselSlider> createState() =>
      _FavoritesCarouselSliderState();
}

class _FavoritesCarouselSliderState extends State<FavoritesCarouselSlider> {
  late Box<Favorites> favoriteBox;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorites');
  }

  @override
  Widget build(BuildContext context) {
    final wishList = favoriteBox.values.toList();
    // ===== Favorite places carousel slider =====

    if (wishList.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.3,
      child: CarouselSlider.builder(
        itemCount: wishList.length,
        itemBuilder: (context, index, realIndex) {
          final displayWishlist = wishList[index];
          return GestureDetector(
            onTap: () => nextScreen(
              context,
              WishlistPlaceDetail(index: index),
            ),
            child: FavoritesCard(
              name: displayWishlist.name,
              favoritesCardImage: displayWishlist.image,
            ),
          );
        },
        options: CarouselOptions(
          scrollPhysics: const BouncingScrollPhysics(),
          // viewportFraction: 1.0,
          pauseAutoPlayInFiniteScroll: true,
          // height: MediaQuery.of(context).size.height / 2.95,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          // autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 3),
        ),
      ),
    );
  }
}
