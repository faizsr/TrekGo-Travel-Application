import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class MainSubtitles extends StatelessWidget {
  final String subtitleText;
  final Function()? onTap;
  const MainSubtitles({
    super.key,
    required this.subtitleText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subtitleText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.darkTeal,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.black38,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
