import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/Main%20Pages/Sub%20pages/place_detail_screen.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/Firebase/card_rating_bar.dart';

class RecommendedCard extends StatelessWidget {
  final String? placeName;
  final double? ratingCount;
  final String recommendedCardImage;
  final String? placeDescription;
  final String? placeLocation;
  const RecommendedCard({
    super.key,
    this.placeName,
    this.ratingCount,
    required this.recommendedCardImage,
    this.placeDescription,
    this.placeLocation,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(
              placeImage: recommendedCardImage,
              placeName: placeName,
              ratingCount: ratingCount,
              description: placeDescription,
              location: placeLocation,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 15,
        ),
        // color: Colors.white,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              recommendedCardImage,
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width / 2.2,
        height: MediaQuery.of(context).size.height / 5.0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30.0,
                sigmaY: 5.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      // blurRadius: 4,
                      // offset: Offset(0, -6),
                      // spreadRadius: 0,
                      // color: Color(0x40000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                      spreadRadius: 2,
                      color: Color(0x0D000000),
                    ),
                  ],
                  color: Colors.black.withOpacity(0.1),
                  // color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // color: Colors.black,
                      width: MediaQuery.of(context).size.width * 0.22,
                      child: Text(
                        placeName ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    CardRatingBar(
                      ratingCount: ratingCount ?? 0,
                      itemSize: 11,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
