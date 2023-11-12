import 'package:flutter/material.dart';

class HelpTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Function()? onPressedSignUp;

  const HelpTextWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    this.onPressedSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedSignUp,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: firstText,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: secondText,
              style: const TextStyle(
                color: Color(0xFF1285b9),
                fontFamily: 'Poppins',
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
