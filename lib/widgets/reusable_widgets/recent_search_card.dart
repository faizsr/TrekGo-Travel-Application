import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/place_detail_screen.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/reusable_widgets/card_rating_bar.dart';

class RecentSearchCard extends StatelessWidget {
  final String? cardImage;
  final String? cardTitle;
  final double? ratingCount;
  final String? placeId;
  final bool? isAdmin;
  final bool? isUser;
  const RecentSearchCard({
    super.key,
    this.cardImage,
    this.cardTitle,
    this.ratingCount,
    this.placeId,
    this.isAdmin,
    this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => nextScreen(
          context,
          PlaceDetailScreen(
            isAdmin: isAdmin,
            isUser: isUser,
            placeid: placeId,
          )),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 4),
                color: Color(0x0D000000),
              )
            ]),
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(3.5),
              width: MediaQuery.of(context).size.width * 0.24,
              height: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  cardImage ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Positioned(
              left: 115,
              top: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardTitle ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CardRatingBar(
                    ratingCount: ratingCount ?? 0,
                    itemSize: 18,
                    isRatingTextNeeded: true,
                  ),
                ],
              ),
            ),
            const Positioned(
              right: 15,
              top: 40,
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
