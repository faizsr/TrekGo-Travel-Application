import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final bool isStarBigger;
  const RatingStar({
    super.key,
    this.isStarBigger = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.star_rounded,
          color: Colors.yellow,
          size: isStarBigger
              ? MediaQuery.of(context).size.width / 31
              : MediaQuery.of(context).size.width / 21,
        ),
        Icon(
          Icons.star_rounded,
          color: Colors.yellow,
          size: isStarBigger
              ? MediaQuery.of(context).size.width / 31
              : MediaQuery.of(context).size.width / 21,
        ),
        Icon(
          Icons.star_rounded,
          color: Colors.yellow,
          size: isStarBigger
              ? MediaQuery.of(context).size.width / 31
              : MediaQuery.of(context).size.width / 21,
        ),
        Icon(
          Icons.star_rounded,
          color: Colors.yellow,
          size: isStarBigger
              ? MediaQuery.of(context).size.width / 31
              : MediaQuery.of(context).size.width / 21,
        ),
        Icon(
          Icons.star_rounded,
          color: Colors.yellow,
          size: isStarBigger
              ? MediaQuery.of(context).size.width / 31
              : MediaQuery.of(context).size.width / 21,
        ),
      ],
    );
  }
}
