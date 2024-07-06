import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class WishlistCard extends StatelessWidget {
  final String? wishlistCardImage;
  final String? name;
  const WishlistCard({
    super.key,
    this.wishlistCardImage,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
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
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(File(wishlistCardImage ?? '')),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.013,
            left: 18,
            right: 18,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3.0,
                  sigmaY: 4.0,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.26,
                  height: MediaQuery.of(context).size.height * 0.035,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 2),
                        spreadRadius: 4,
                        color: Color(0x1A000000),
                      ),
                    ],
                    color: Colors.white.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(
                            name ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
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
