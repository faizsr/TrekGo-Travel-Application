import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';

class CountCard extends StatelessWidget {
  final String count;
  final String title;
  final IconData icon;

  const CountCard({
    super.key,
    required this.count,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            IconButton(
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: AppColors.skyBlue,
              ),
              onPressed: () {},
              icon: Icon(icon, size: 26),
            ),
            const Gap(height: 8),
            Text(
              title,
              style: TextStyle(color: AppColors.black38),
            ),
            Text(
              count,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: AppColors.darkTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
