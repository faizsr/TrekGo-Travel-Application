import 'package:flutter/material.dart';

class ScrollButtons extends StatefulWidget {
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonBgColor;
  final Color buttonBrColor;

  const ScrollButtons(
      {super.key,
      required this.buttonText,
      required this.buttonTextColor,
      required this.buttonBgColor,
      required this.buttonBrColor});

  @override
  State<ScrollButtons> createState() => _ScrollButtonsState();
}

class _ScrollButtonsState extends State<ScrollButtons> {
  bool isButtonSelected = false;
  void toggleButton() {
    setState(() {
      isButtonSelected = !isButtonSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 2,
              color: const Color(
                0x1A000000,
              ).withOpacity(0.095),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: widget.buttonBgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            side: BorderSide(
              width: 2.5,
              color: widget.buttonBrColor,
            ),
          ),
          // style: ButtonStyle(
          //   foregroundColor: MaterialStateProperty.resolveWith<Color>(
          //     (Set<MaterialState> states) {
          //       if (states.contains(MaterialState.pressed)) {
          //         return Colors.white;
          //       }
          //       return isButtonSelected ? Colors.blue : Colors.black;
          //     },
          //   ),
          //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //     (Set<MaterialState> states) {
          //       if (states.contains(MaterialState.pressed)) {
          //         return Colors.black;
          //       }
          //       return isButtonSelected ? Colors.yellow : Colors.white;
          //     },
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              widget.buttonText,
              style: TextStyle(
                color: widget.buttonTextColor,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
