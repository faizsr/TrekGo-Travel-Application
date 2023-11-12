import 'package:flutter/material.dart';

class MainSubtitles extends StatelessWidget {
  final String subtitleText;
  final Function()? viewAllPlaces;
  const MainSubtitles({
    super.key,
    required this.subtitleText,
    this.viewAllPlaces,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        top: MediaQuery.of(context).size.height * 0.015,
        right: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subtitleText,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color(0xFF1285b9),
            ),
          ),
          GestureDetector(
            onTap: viewAllPlaces,
            child: const Text(
              'View all',
              style: TextStyle(
                fontSize: 11,
                color: Color(0x66000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
