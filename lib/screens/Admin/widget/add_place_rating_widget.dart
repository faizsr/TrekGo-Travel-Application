import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStarWidget extends StatefulWidget {
  final bool onUpdate;
  final double? initialRatingCount;
  final Function(double?)? onRatingPlace;
  const RatingStarWidget({
    super.key,
    this.onUpdate = false,
    this.initialRatingCount,
    this.onRatingPlace,
  });

  @override
  State<RatingStarWidget> createState() => _RatingStarWidgetState();
}

class _RatingStarWidgetState extends State<RatingStarWidget> {
  double? ratingCount = 0;
  double? initailRating;

  @override
  void initState() {
    initailRating = widget.initialRatingCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: widget.initialRatingCount ?? 0,
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
              initailRating = rating;
              ratingCount = rating;
              widget.onRatingPlace!(ratingCount);
            });
          },
        ),
        widget.onUpdate == true
            ? Text('Rating $initailRating')
            : Text('Rating $ratingCount'),
      ],
    );
  }
}
