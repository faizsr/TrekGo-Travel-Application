import 'package:flutter/material.dart';

class TextFieldWidgetTwo extends StatelessWidget {
  final String? hintText;
  final bool minmaxLine;
  final bool readOnly;
  final Function(String)? onChanged;

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const TextFieldWidgetTwo({
    super.key,
    this.hintText,
    this.minmaxLine = false,
    this.readOnly = false,
    this.onChanged,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: TextFormField(
        readOnly: readOnly,
        validator: validator,
        controller: controller,
        minLines: null,
        maxLines: minmaxLine ? 4 : null,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0x66000000),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
