import 'package:flutter/material.dart';

class SectionTitles extends StatelessWidget {
  final String titleText;
  const SectionTitles({super.key, required this.titleText,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 10, top: 20),
      child: Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }
}
