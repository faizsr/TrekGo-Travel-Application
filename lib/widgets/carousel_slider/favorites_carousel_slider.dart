import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trekmate_project/model/favorite.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_place_detail.dart';
import 'package:trekmate_project/widgets/reusable_widgets/favorite_card.dart';

class FavoritesCarouselSlider extends StatefulWidget {
  final String? currentUserId;
  const FavoritesCarouselSlider({
    super.key,
    this.currentUserId,
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
    var wishList = filteredList!.where((wishlist) => wishlist.userId == widget.currentUserId).toList();
    // ===== Favorite places carousel slider =====

    if (wishList.isEmpty) {
      return const SizedBox();
    } else {
      return wishList.isEmpty
          ? const SizedBox()
          : SizedBox(
              height: MediaQuery.of(context).size.height / 3.3,
              child: CarouselSlider.builder(
                itemCount: wishList.length,
                itemBuilder: (context, index, realIndex) {
                  final displayWishlist = wishList[index];

                  debugPrint('user id on carousel ${displayWishlist.userId}');
                  debugPrint('user id in firebase ${widget.currentUserId}');

                  if (displayWishlist.userId == widget.currentUserId) {
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
                  } else {
                    return Container();
                  }
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
}
