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
  final Color? buttonColor;
  final Color? buttonTxtColor;
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
    this.buttonColor,
    this.buttonTxtColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth ?? MediaQuery.of(context).size.width / 3,
      height: 34,
      child: isOutlinedButton
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: buttonColor ?? const Color(0xFF1285b9),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(buttonBorderRadius ?? 7.65),
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
                    style: TextStyle(
                      fontWeight: buttonTextWeight ?? FontWeight.bold,
                      fontSize: buttonTextSize ?? 12,
                      color: buttonTxtColor ?? Colors.white,
                    ),
                  ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: buttonColor ?? const Color(0xFF1285b9),
                shape: RoundedRectangleBorder(
                  borderRadius: buttonBorderRadius == null
                      ? BorderRadius.circular(7.65)
                      : BorderRadius.circular(buttonBorderRadius ?? 0),
                ),
                disabledBackgroundColor: buttonColor ?? const Color(0xB31285b9),
              ),
              onPressed: buttonOnPressed,
              child: loadingWidget ??
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: buttonTextWeight ?? FontWeight.w700,
                      fontSize: buttonTextSize ?? 12,
                      color: buttonTxtColor ?? Colors.white,
                    ),
                  ),
            ),
    );
  }
}
