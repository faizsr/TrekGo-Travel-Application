import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  final double? widthValue;
  final String? buttonText;
  final void Function()? onPressed;
  const BottomButtons({
    super.key,
    this.widthValue,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthValue!,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFe5e6f6),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          child: Text(
            buttonText!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
