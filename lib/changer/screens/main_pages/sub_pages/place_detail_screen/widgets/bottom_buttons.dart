import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class BottomButtons extends StatelessWidget {
  final double? widthValue;
  final String buttonText;
  final void Function() onPressed;
  const BottomButtons({
    super.key,
    this.widthValue,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.darkTeal,
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 14, color: AppColors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
