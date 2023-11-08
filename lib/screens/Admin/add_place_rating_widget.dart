// import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStarWidget extends StatefulWidget {
  final Function(double?)? onRatingPlace;
  const RatingStarWidget({
    super.key,
    this.onRatingPlace,
  });

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  double? ratingCount = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          // initialRating: 3,
          unratedColor: Colors.grey.shade300,
          glow: false,
          // minRating: 1,
          allowHalfRating: true,
          itemBuilder: (context, _) {
            return const Icon(
              Icons.star_rounded,
              color: Colors.yellow,
            );
          },
          onRatingUpdate: (rating) {
            debugPrint(rating.toString());
            setState(() {
              ratingCount = rating;
              widget.onRatingPlace!(ratingCount);
            });
          },
        ),
        Text('Rating $ratingCount'),
      ],
    );
  }
}
