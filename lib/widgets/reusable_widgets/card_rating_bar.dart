// import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardRatingBar extends StatefulWidget {
  final bool isMainAlignCenter;
  final bool isRatingTextNeeded;
  final double? itemSize;
  final double? ratingCount;
  const CardRatingBar({
    super.key,
    this.isMainAlignCenter = false,
    this.isRatingTextNeeded = false,
    this.itemSize,
    this.ratingCount,
  });

  @override
  State<CardRatingBar> createState() => _CardRatingBarState();
}

class _CardRatingBarState extends State<CardRatingBar> {
  double? ratingCount = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.isMainAlignCenter? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingBar(
          ignoreGestures: true,
          itemSize: widget.itemSize ?? 0,
          initialRating: widget.ratingCount ?? 0,
          unratedColor: Colors.grey.shade300,
          glow: false,
          // minRating: 1,
          allowHalfRating: true,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star_rounded,
              color: Colors.yellow,
            ),
            half: const Icon(
              Icons.star_half_rounded,
              color: Colors.yellow,
            ),
            empty: const Icon(
              Icons.star_outline_rounded,
              color: Colors.yellow,
            ),
          ),
          onRatingUpdate: (rating) {
            debugPrint(rating.toString());
            setState(() {
              rating = widget.ratingCount ?? 0;
              // widget.onRatingPlace!(ratingCount);
            });
          },
        ),
        const SizedBox(
          width: 5,
        ),
        widget.isRatingTextNeeded
            ? Text(
                '(${widget.ratingCount})',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0x80000000),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
