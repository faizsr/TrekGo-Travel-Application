import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// =============== Star rating bar ===============

class CardRatingBar extends StatefulWidget {
  final bool isMainAlignCenter;
  final bool isRatingTextNeeded;
  final double? itemSize;
  final num? ratingCount;
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
      // mainAxisAlignment: widget.isMainAlignCenter
      //     ? MainAxisAlignment.center
      //     : MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingBar(
          ignoreGestures: true,
          itemSize: widget.itemSize ?? 0,
          initialRating: widget.ratingCount?.toDouble() ?? 0,
          unratedColor: Colors.grey.shade300,
          glow: false,
          // minRating: 1,
          allowHalfRating: true,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star_rounded,
              color: Color(0xFFFFD711),
            ),
            half: const Icon(
              Icons.star_half_rounded,
              color: Color(0xFFFFD711),
            ),
            empty: const Icon(
              Icons.star_outline_rounded,
              color: Color(0xFFFFD711),
            ),
          ),
          onRatingUpdate: (rating) {
            debugPrint(rating.toString());
            setState(() {
              rating = widget.ratingCount?.toDouble() ?? 0;
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

// =============== Card Button used for update & delete ===============

class CardButton extends StatelessWidget {
  final String? buttonText;
  const CardButton({
    super.key,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF1285b9),
        ),
        child: Center(
          child: Text(
            buttonText ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// =============== Title widget used of sections ===============

class SectionTitles extends StatelessWidget {
  final String titleText;
  final double? noPadding;
  final double? textSize;
  const SectionTitles({
    super.key,
    required this.titleText,
    this.noPadding,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: noPadding ?? 15, bottom: 10, top: noPadding ?? 20),
      child: Text(
        titleText,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: textSize ?? 16,
        ),
      ),
    );
  }
}

// =============== Text form field widget used for add, update ===============

