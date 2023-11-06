import 'package:flutter/material.dart';

class SavedIcon extends StatelessWidget {
  final bool biggerIcon;
  const SavedIcon({
    super.key,
    this.biggerIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Icon(
        Icons.bookmark_rounded,
        size: biggerIcon? MediaQuery.of(context).size.width / 10 : MediaQuery.of(context).size.width / 14 ,
        color: const Color(0xFF1285b9),
      ),
    );
  }
}
