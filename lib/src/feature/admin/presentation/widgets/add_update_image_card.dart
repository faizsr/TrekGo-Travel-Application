import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';

class AddUpdateImageCard extends StatelessWidget {
  final String? selectedImage;
  final String? imageUrl;
  final Function()? onPressed;
  const AddUpdateImageCard({
    super.key,
    this.selectedImage,
    this.imageUrl,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: selectedImage != null
            ? DecorationImage(
                image: FileImage(File(selectedImage!)),
                fit: BoxFit.cover,
              )
            : imageUrl != null
                ? DecorationImage(
                    image: Image.network(imageUrl!).image,
                    fit: BoxFit.cover,
                  )
                : null,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: kBoxShadow2,
      ),
      height: 240,
      child: Center(
        // ===== Choose image button =====
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onPressed,
          child: const Text(
            'CHOOSE IMAGE',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
