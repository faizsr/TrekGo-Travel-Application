import 'package:flutter/material.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/review_card.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';

class ReviewsBottomSheet extends StatelessWidget {
  const ReviewsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                'All Reviews',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(height: 5),
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.black12,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              const Gap(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: List.generate(12, (index) => const ReviewCard()),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
