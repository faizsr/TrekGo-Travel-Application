import 'package:flutter/material.dart';

class ButtonsWidget extends StatelessWidget {
  final String buttonText;
  final double? buttonWidth;
  final bool isOutlinedButton;
  final Function()? buttonOnPressed;
  final Widget? loadingWidget;
  final double? buttonBorderRadius;
  final double? buttonTextSize;
  final FontWeight? buttonTextWeight;

  const ButtonsWidget({
    super.key,
    required this.buttonText,
    this.buttonWidth,
    this.isOutlinedButton = false,
    this.buttonOnPressed,
    this.loadingWidget,
    this.buttonBorderRadius,
    this.buttonTextSize,
    this.buttonTextWeight,
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
                ),
                // disabledBackgroundColor: const Color(0xCC1285b9),
              ),
              onPressed: buttonOnPressed,
              child: loadingWidget ??
                  Text(
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
                  borderRadius: buttonBorderRadius == null
                      ? BorderRadius.circular(7.65)
                      : BorderRadius.circular(buttonBorderRadius ?? 0),
                ),
                disabledBackgroundColor: const Color(0xB31285b9),
              ),
              onPressed: buttonOnPressed,
              child: loadingWidget ??
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: buttonTextWeight ?? FontWeight.w700,
                      fontSize: buttonTextSize ?? 12,
                      color: Colors.white,
                    ),
                  ),
            ),
    );
  }
}
