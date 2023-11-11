import 'dart:ui';

import 'package:flutter/material.dart';

class PlaceCardButton extends StatelessWidget {
  final String? buttonText;
  const PlaceCardButton({
    super.key,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 30.0,
          sigmaY: 5.0,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white12,
          ),
          child: Center(
            child: Text(
              buttonText ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
