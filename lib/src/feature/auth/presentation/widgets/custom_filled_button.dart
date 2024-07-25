import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isBlurred;
  final Widget? child;
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isBlurred = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final sigma = isBlurred ? 4.0 : 0.0;
    final opacity = isBlurred ? 0.8 : 1.0;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // padding: const EdgeInsets.symmetric(horizontal: 40),
              elevation: 0,
              backgroundColor: AppColors.darkTeal.withOpacity(opacity),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            iconAlignment: IconAlignment.end,
            onPressed: onPressed,
            child: child ??
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
