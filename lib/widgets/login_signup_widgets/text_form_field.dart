import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? fieldTitle;
  final String fieldHintText;
  final bool noPaddingNeeded;
  final bool colorIsWhite;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const TextFieldWidget({
    super.key,
    this.fieldTitle,
    required this.fieldHintText,
    this.noPaddingNeeded = false,
    this.colorIsWhite = false,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: noPaddingNeeded
          ? const EdgeInsets.all(0)
          : const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 7,
              bottom: noPaddingNeeded ? 0 : 7,
            ),
            child: fieldTitle != null
                ? Text(
                    fieldTitle!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1285b9),
                      fontSize: 11,
                    ),
                  )
                : const SizedBox(),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                  color: colorIsWhite
                      ? const Color(0x0D000000)
                      : const Color(0x1A000000),
                )
              ],
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                fillColor:
                    colorIsWhite ? Colors.white : const Color(0xFFeaeBf8),
                filled: true,
                hintText: fieldHintText,
                hintStyle: const TextStyle(
                  color: Color(0x66000000),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(
                    color: const Color(0xFFdfe6f4),
                    width: noPaddingNeeded ? 0.0 : 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0x0D1285b9),
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
