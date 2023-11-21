import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trekmate_project/model/favorite.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_place_detail.dart';
import 'package:trekmate_project/widgets/reusable_widgets/favorite_card.dart';

class FavoritesCarouselSlider extends StatefulWidget {
  const FavoritesCarouselSlider({
    super.key,
  });

  @override
  State<FavoritesCarouselSlider> createState() =>
      _FavoritesCarouselSliderState();
}

class _FavoritesCarouselSliderState extends State<FavoritesCarouselSlider> {
  late Box<Favorites> favoriteBox;
  List<Favorites>? filteredList;

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box('favorites');
    filteredList = favoriteBox.values.toList();
  }

  updateData() {
    setState(() {
      filteredList = favoriteBox.values.toList();
    });
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    updateData();
    debugPrint('Refresh on favorite');
  }

  @override
  Widget build(BuildContext context) {
    var wishList = filteredList;
    // ===== Favorite places carousel slider =====

    if (wishList == null) {
      return const SizedBox();
    } else {
      return RefreshIndicator(
        onRefresh: refreshData,
        child: wishList.isEmpty
            ? const SizedBox()
            : SizedBox(
                height: MediaQuery.of(context).size.height / 3.3,
                child: CarouselSlider.builder(
                  itemCount: wishList.length,
                  itemBuilder: (context, index, realIndex) {
                    final displayWishlist = wishList[index];
                    return GestureDetector(
                      onTap: () async {
                        String refresh = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WishlistPlaceDetail(
                              index: index,
                            ),
                          ),
                        );
                        if (refresh == 'refresh') {
                          updateData();
                        }
                      },
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
              ),
      );
    }
  }
}
