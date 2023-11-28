import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStarWidget extends StatefulWidget {
  final bool onUpdate;
  final bool onUserRating;
  final bool isTextNeeded;
  final double? initialRatingCount;
  final Function(double?)? onRatingPlace;
  final Color? unRatedColor;
  final Color? ratedColor;
  const RatingStarWidget({
    super.key,
    this.onUpdate = false,
    this.onUserRating = false,
    this.isTextNeeded = false,
    this.initialRatingCount,
    this.onRatingPlace,
    this.unRatedColor,
    this.ratedColor,
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
        widget.onUserRating == true
            ? Text(
                '${ratingCount == 0 ? initailRating : ratingCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              )
            : const SizedBox(),
        RatingBar.builder(
          initialRating: widget.initialRatingCount ?? 0,
          unratedColor: widget.unRatedColor ?? Colors.yellow.shade300,
          glow: false,
          allowHalfRating: true,
          itemBuilder: (context, index) {
            return Icon(
              Icons.star_rounded,
              color: widget.ratedColor ?? Colors.yellow.shade600,
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
            ? widget.isTextNeeded
                ? Text('Rating $initailRating')
                : Text('Rating $ratingCount')
            : const SizedBox(),
      ],
    );
  }
}
