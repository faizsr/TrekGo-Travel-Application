import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_outlined_button.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_text_field.dart';

import '../../../../auth/presentation/widgets/custom_filled_button.dart';

class ReviewAddDialog extends StatelessWidget {
  const ReviewAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Review',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTeal,
              ),
            ),
            const Gap(height: 5),
            Row(
              children: [
                RatingBar(
                  glow: false,
                  allowHalfRating: true,
                  initialRating: 3.5,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star_rounded,
                      color: Colors.amberAccent,
                    ),
                    half: const Icon(
                      Icons.star_half_rounded,
                      color: Colors.amberAccent,
                    ),
                    empty: const Icon(
                      Icons.star_outline_rounded,
                      color: Colors.amberAccent,
                    ),
                  ),
                  onRatingUpdate: (value) {},
                ),
                const Gap(width: 10),
                Text(
                  '(3.5)',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.black38,
                  ),
                ),
              ],
            ),
            const CustomTextField(
              hintText: 'Write here...',
            ),
            const Gap(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    text: 'Cancel',
                  ),
                ),
                const Gap(width: 10),
                Expanded(
                  child: CustomFilledButton(
                    onPressed: () {},
                    text: 'Post',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
