import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/place_detail_screen/widgets/reviews.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_outlined_button.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/review_add_dialog.dart';

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
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: Column(
                                      children: List.generate(
                                        12,
                                        (index) => const ReviewCard(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
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
}
