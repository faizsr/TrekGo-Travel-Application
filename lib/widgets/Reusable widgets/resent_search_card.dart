import 'package:flutter/material.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/rating_star.dart';

class RecentSearchCard extends StatelessWidget {
  final String cardImage;
  final String cardTitle;
  const RecentSearchCard({
    super.key,
    required this.cardImage,
    required this.cardTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Image.asset(
                cardImage,
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
                  cardTitle,
                  style:const  TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const RatingStar(),
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
    );
  }
}
