import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.darkTeal,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: AppColors.lightTeal,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
