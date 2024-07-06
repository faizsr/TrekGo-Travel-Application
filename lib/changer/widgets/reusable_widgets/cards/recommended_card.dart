import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/place_detail_screen/place_detail_screen.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';

class RecommendedCard extends StatelessWidget {
  final bool? isAdmin;
  final bool? isUser;
  final String userId;
  final String? placeid;
  final String? placeCategory;
  final String? placeState;
  final String? placeName;
  final double? ratingCount;
  final String recommendedCardImage;
  final String? placeDescription;
  final String? placeLocation;
  final DocumentSnapshot? destinationSnapshot;
  const RecommendedCard({
    super.key,
    this.isAdmin,
    this.isUser,
    required this.userId,
    this.placeid,
    this.placeCategory,
    this.placeState,
    this.placeName,
    this.ratingCount,
    required this.recommendedCardImage,
    this.placeDescription,
    this.placeLocation,
    this.destinationSnapshot,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => nextScreen(
        context,
        PlaceDetailScreen(
          userId: userId,
          isAdmin: isAdmin ?? true,
          isUser: isUser ?? false,
          placeid: placeid,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              color: Color(0x0D000000),
            )
          ],
        ),
        width: MediaQuery.of(context).size.width / 2.3,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.3,
              height: MediaQuery.of(context).size.height / 5.1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    lazyLoading,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: recommendedCardImage,
                  errorWidget: (context, url, error) =>
                      Image.asset(lazyLoading, fit: BoxFit.cover),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      placeName?.replaceAll(RegExp(r'\s+'), ' ') ?? '',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 20, 106, 146),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  CardRatingBar(
                    ratingCount: ratingCount ?? 0,
                    itemSize: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
