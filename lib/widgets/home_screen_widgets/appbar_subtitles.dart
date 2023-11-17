import 'package:flutter/material.dart';

class AppbarSubtitles extends StatelessWidget {
  final String? subtitleText;
  final double? subtitleSize;
  final Color? subtitleColor;
  const AppbarSubtitles({
    super.key,
    this.subtitleText,
    this.subtitleSize,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitleText!,
      style: TextStyle(
        fontSize: subtitleSize,
        fontWeight: FontWeight.w600,
        color: subtitleColor,
      ),
    );
  }
}
