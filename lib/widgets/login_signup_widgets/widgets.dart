import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// =============== Custom buttons ===============

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


// =============== Help text widget ===============

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


// =============== Custom text form field ===============

class TextFieldWidget extends StatelessWidget {
  final String? fieldTitle;
  final String fieldHintText;
  final bool noPaddingNeeded;
  final bool colorIsWhite;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    this.fieldTitle,
    required this.fieldHintText,
    this.noPaddingNeeded = false,
    this.colorIsWhite = false,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: noPaddingNeeded
          ? const EdgeInsets.all(0)
          : const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 7,
              bottom: noPaddingNeeded ? 0 : 7,
            ),
            child: fieldTitle != null
                ? Text(
                    fieldTitle!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1285b9),
                      fontSize: 11,
                    ),
                  )
                : const SizedBox(),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                  color: colorIsWhite
                      ? const Color(0x0D000000)
                      : const Color(0x1A000000),
                )
              ],
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              style: const TextStyle(fontSize: 15),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                fillColor:
                    colorIsWhite ? Colors.white : const Color(0xFFeaeBf8),
                filled: true,
                hintText: fieldHintText,
                hintStyle: const TextStyle(
                  color: Color(0x66000000),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: const Color(0xFFdfe6f4),
                    width: noPaddingNeeded ? 0.0 : 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0x0D1285b9),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}

// =============== Text form field heading ===============

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


// =============== Custom back button ===============

class CustomBackButton extends StatelessWidget {
  final Function()? pageNavigator;
  const CustomBackButton({
    super.key,
    this.pageNavigator,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 10,
      child: IconButton(
        onPressed: pageNavigator,
        icon: Icon(
          MdiIcons.keyboardBackspace,
          size: 30,
        ),
      ),
    );
  }
}


