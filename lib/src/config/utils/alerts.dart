import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class CustomAlerts {
  static SnackBar snackBar(String message) {
    return SnackBar(
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColors.darkTeal,
      elevation: 0,
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
  }
}
