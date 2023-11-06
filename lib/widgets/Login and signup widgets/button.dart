import 'package:flutter/material.dart';

class ButtonsWidget extends StatelessWidget {
  final String buttonText;
  // final Color? buttonBgColor;
  final double? buttonWidth;
  final bool isOutlinedButton;
  final Function()? buttonOnPressed;

  const ButtonsWidget({
    super.key,
    required this.buttonText,
    // this.buttonBgColor,
    this.buttonWidth,
    this.isOutlinedButton = false,
    this.buttonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth ?? MediaQuery.of(context).size.width / 3,
      height: 34,
      child: isOutlinedButton
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.65),
                  ),
                  side: const BorderSide(
                    width: 1,
                    color: Color(0xFF1285b9),
                  )),
              onPressed: buttonOnPressed,
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color(0xFF1285b9),
                ),
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF1285b9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.65),
                ),
              ),
              onPressed: buttonOnPressed,
              child: Text(
                buttonText,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.white),
              ),
            ),
    );
  }
}
