import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WishlistCardAll extends StatelessWidget {
  final String backgroundImage;
  final String placeName;

  const WishlistCardAll({
    super.key,
    required this.backgroundImage,
    required this.placeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.2,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(0, 10),
            spreadRadius: 0,
            color: Color(0x1A000000),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(backgroundImage)),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.018,
            left: 18,
            right: 18,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 7.0,
                  sigmaY: 4.0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.26,
                  height: MediaQuery.of(context).size.height * 0.04,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 2),
                        spreadRadius: 4,
                        color: Color(0x1A000000),
                      ),
                    ],
                    color: Colors.white12,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          placeName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
