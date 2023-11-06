import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/rating_star.dart';

class RecommendedCard extends StatelessWidget {
  final String recommendedCardImage;
  const RecommendedCard({
    super.key,
    required this.recommendedCardImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          image: AssetImage(
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
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, -6),
                    spreadRadius: 0,
                    color: Color(0x40000000),
                  ),
                ],
                color: Colors.black.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 27.0,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Jew Town',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RatingStar(
                    isStarBigger: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
