import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: AppColors.lightTeal,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
