import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                placeholder: AssetImage(defaultImage),
                fit: BoxFit.cover,
                image: Image.asset(defaultImage).image,
              ),
            ),
          ),
          const Gap(width: 10),
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(height: 4),
                        CardRatingBar(
                          itemSize: 20,
                          ratingCount: 3,
                        ),
                      ],
                    ),
                    Text(
                      '10-Jul-24',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Gap(height: 4),
                Text(
                  'Very Good Place',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
