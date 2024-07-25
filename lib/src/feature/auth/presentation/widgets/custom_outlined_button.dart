import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double height;
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            width: 1.5,
            color: AppColors.lightBlue,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        iconAlignment: IconAlignment.end,
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: AppColors.darkTeal,
          ),
        ),
      ),
    );
  }
}
