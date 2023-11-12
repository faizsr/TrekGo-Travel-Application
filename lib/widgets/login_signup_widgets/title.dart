import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final double mainTextSize;
  final String mainText;
  final bool isMainTextWeight;
  const TitleWidget({
    super.key,
    required this.mainText,
    required this.mainTextSize,
    this.isMainTextWeight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      mainText,
      style: TextStyle(
        color: const Color(0xFF1285b9),
        fontSize: mainTextSize,
        fontWeight: isMainTextWeight ? FontWeight.bold : FontWeight.w900,
        shadows: const [
          Shadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
