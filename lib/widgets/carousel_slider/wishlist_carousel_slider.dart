import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trekmate_project/model/wishlist.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/wishlist_place_detail.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/reusable_widgets/cards/wishlist_card.dart';

class WishlistCarouselSlider extends StatefulWidget {
  final String? currentUserId;
  const WishlistCarouselSlider({
    super.key,
    this.currentUserId,
  });

  @override
  State<WishlistCarouselSlider> createState() => _WishlistCarouselSliderState();
}

class _WishlistCarouselSliderState extends State<WishlistCarouselSlider> {
  late Box<Wishlist> wishlistBox;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    wishlistBox = Hive.box('wishlists');
    debugPrint('User id on wislist slider: ${widget.currentUserId}');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: wishlistBox.listenable(),
      builder: (context, Box<Wishlist> wishlistBox, child) {
        var wishList = wishlistBox.values
            .where((wishlist) => wishlist.userId == widget.currentUserId)
            .toList();

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
                    debugPrint(
                        'hive key on carousel ${displayWishlist.hiveKey}');

                    return GestureDetector(
                      onTap: () async {
                        debugPrint('wishlist slider index : $index');

                        await nextScreen(
                          context,
                          WishlistPlaceDetail(
                            userId: displayWishlist.userId,
                            hiveKey: displayWishlist.hiveKey,
                          ),
                        );
                      },
                      child: WishlistCard(
                        name: displayWishlist.name,
                        wishlistCardImage: displayWishlist.image,
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
      },
    );
  }
}
