import 'package:flutter/material.dart';

class SavedIcon extends StatefulWidget {
  final bool biggerIcon;
  const SavedIcon({
    super.key,
    this.biggerIcon = false,
  });

  @override
  State<SavedIcon> createState() => _SavedIconState();
}

bool iconFill = false;

class _SavedIconState extends State<SavedIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          iconFill = !iconFill;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.090,
        height: MediaQuery.of(context).size.height * 0.045,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0x0D000000),
            )
          ],
        ),
        child: iconFill
            ? Icon(
                Icons.bookmark_rounded,
                size: widget.biggerIcon
                    ? MediaQuery.of(context).size.width / 10
                    : MediaQuery.of(context).size.width / 14,
                color: const Color(0xFF1285b9),
              )
            : Icon(
                Icons.bookmark_outline,
                size: widget.biggerIcon
                    ? MediaQuery.of(context).size.width / 10
                    : MediaQuery.of(context).size.width / 14,
                color: const Color(0xFF1285b9),
              ),
      ),
    );
  }
}
