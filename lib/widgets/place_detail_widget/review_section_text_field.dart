import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class ReviewTextField extends StatefulWidget {
  const ReviewTextField({super.key});

  @override
  State<ReviewTextField> createState() => _ReviewTextFieldState();
}

final TextEditingController reviewController = TextEditingController();

class _ReviewTextFieldState extends State<ReviewTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: reviewController,
      onChanged: (value) {},
      decoration: const InputDecoration(
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(FeatherIcons.send),
        ),
        suffixIconColor: Colors.grey,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        hintText: 'Add a comment',
        hintStyle: TextStyle(
          color: Color(0x66000000),
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
