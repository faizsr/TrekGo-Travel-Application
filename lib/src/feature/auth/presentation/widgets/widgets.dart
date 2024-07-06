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
                '${ratingCount == 0 ? initailRating ?? 0 : ratingCount}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              )
            : const SizedBox(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBar.builder(
              initialRating: widget.initialRatingCount ?? 0,
              unratedColor: widget.unRatedColor ?? Colors.yellow.shade500,
              glow: false,
              allowHalfRating: true,
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star_rounded,
                  color: widget.ratedColor ?? const Color(0xFFFFD711),
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
            const SizedBox(
              width: 8,
            ),
            widget.onUpdate == true
                ? widget.isTextNeeded
                    ? Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          '($initailRating)',
                          style: const TextStyle(fontSize: 18),
                        ))
                    : Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          '($ratingCount)',
                          style: const TextStyle(fontSize: 20),
                        ))
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}

// =============== Drop down widget ===============
class EditDropDownWidget extends StatefulWidget {
  final String? hintText;
  final String? updateState;
  final String? updateGender;
  final double? leftPadding;
  final double? rightPadding;
  final Function(String?)? onGenderSelectionChange;
  final String? Function(String?)? validator;
  const EditDropDownWidget({
    super.key,
    this.hintText,
    this.updateState,
    this.updateGender,
    this.leftPadding,
    this.rightPadding,
    this.onGenderSelectionChange,
    this.validator,
  });

  @override
  State<EditDropDownWidget> createState() => _EditDropDownWidgetState();
}

class _EditDropDownWidgetState extends State<EditDropDownWidget> {
  final genderList = ['Male', 'Female', 'Other'];

  String? selectedGender;

  @override
  void initState() {
    super.initState();
    debugPrint('Gender : ${widget.updateGender}');
    selectedGender = widget.updateGender;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        border: Border.all(width: 2, color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: DropdownButton(
            elevation: 2,
            isExpanded: true,
            menuMaxHeight: 300,
            borderRadius: BorderRadius.circular(20),
            icon: const Icon(Icons.arrow_drop_down),
            hint: Text(
              widget.hintText ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0x66000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            value: selectedGender,
            items: genderList.map((newValue) {
              return DropdownMenuItem(
                value: newValue,
                child: Text(newValue),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedGender = newValue.toString();
                debugPrint(selectedGender);
                widget.onGenderSelectionChange!(selectedGender);
              });
            },
          ),
        ),
      ),
    );
  }
}
