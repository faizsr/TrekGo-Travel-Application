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
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        border: Border.all(width: 2, color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: DropdownButton(
            elevation: 2,
            isExpanded: true,
            menuMaxHeight: 300,
            borderRadius: BorderRadius.circular(20),
            icon: const Icon(Icons.arrow_drop_down),
            hint: Text(
              widget.hintText ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0x66000000),
                fontWeight: FontWeight.w500,
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
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
        ),
      ),
    );
  }
}
