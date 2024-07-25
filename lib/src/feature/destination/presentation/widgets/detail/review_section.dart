import 'package:flutter/material.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/review_card.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_outlined_button.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/review_add_dialog.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/reviews_bottom_sheet.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
        boxShadow: kBoxShadow2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTeal,
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTapShowBottomSheet(context);
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.black38,
                  ),
                ),
              ),
            ],
          ),
          const Gap(height: 15),
          Column(
            children: List<Widget>.generate(
              2,
              (index) => const ReviewCard(),
            ).followedBy([
              CustomOutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const ReviewAddDialog();
                    },
                  );
                },
                text: 'Write one...?',
              )
            ]).toList(),
          )
        ],
      ),
    );
  }

  onTapShowBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      context: context,
      builder: (BuildContext context) {
        return const ReviewsBottomSheet();
      },
    );
  }
}
