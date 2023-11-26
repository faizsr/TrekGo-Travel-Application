import 'package:flutter/material.dart';

class EditDropDownWidget extends StatefulWidget {
  final String? hintText;
  final String? updateState;
  final String? updateGender;
  final double? leftPadding;
  final double? rightPadding;
  final Function(String?)? onGenderSelectionChange;
  final String? Function(String?)? validator;
  const EditDropDownWidget({
    super.key,
    this.hintText,
    this.updateState,
    this.updateGender,
    this.leftPadding,
    this.rightPadding,
    this.onGenderSelectionChange,
    this.validator,
  });

  @override
  State<EditDropDownWidget> createState() => _EditDropDownWidgetState();
}

class _EditDropDownWidgetState extends State<EditDropDownWidget> {
  final genderList = ['Male', 'Female', 'Other'];

  String? selectedGender;

  @override
  void initState() {
    super.initState();
    debugPrint('Gender : ${widget.updateGender}');
    selectedGender = widget.updateGender;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.1,
      child: DropdownButtonFormField(
        isExpanded: true,
        menuMaxHeight: 300,
        validator: widget.validator,
        borderRadius: BorderRadius.circular(20),
        padding: EdgeInsets.only(
          left: widget.leftPadding ?? 0,
          right: widget.rightPadding ?? 0,
        ),
        // dropdownColor: Colors.amber,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            left: 15,
            right: 3,
            top: 16,
            bottom: 13,
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
        icon: const Icon(Icons.arrow_drop_down),
        hint: Text(
          widget.hintText ?? '',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0x66000000),
            fontWeight: FontWeight.w500,
          ),
        ),
        value: selectedGender,
        items: genderList.map((newValue) {
          return DropdownMenuItem(
            value: newValue,
            child: Text(newValue),
          );
        }).toList(),

        onChanged: (newValue) {
          setState(() {
            selectedGender = newValue.toString();
            debugPrint(selectedGender);
            widget.onGenderSelectionChange!(selectedGender);
          });
        },
      ),
    );
  }
}
