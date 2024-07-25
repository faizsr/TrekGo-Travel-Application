import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final String? hintText;
  final String? updateCategory;
  final String? updateState;
  final String? updateGender;
  final double? leftPadding;
  final double? rightPadding;
  final double? iconLeftPadding;
  final double? iconRightPadding;
  final bool listSelect;
  final Function(String?)? onCategorySelectionChange;
  final Function(String?)? onStateCelectionChange;
  final Function(String?)? onGenderSelectionChange;
  final String? Function(String?)? validator;
  final bool? isExpanded;
  const DropDownWidget({
    super.key,
    this.hintText,
    this.updateCategory,
    this.updateState,
    this.updateGender,
    this.leftPadding,
    this.rightPadding,
    this.iconLeftPadding,
    this.iconRightPadding,
    this.listSelect = false,
    this.onCategorySelectionChange,
    this.onStateCelectionChange,
    this.onGenderSelectionChange,
    this.validator,
    this.isExpanded,
  });

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  final categoryList = ['Popular', 'Recommended'];
  final stateList = [
    'Kerala',
    'Karnataka',
    'Rajasthan',
    'Goa',
    'Himachal Pradesh',
    'Tamil Nadu',
    'Meghalaya',
    'Gujarat',
    'Andhra pradesh',
    'Madhya Pradesh',
    'Maharashtra',
  ];
  final genderList = ['Male', 'Female', 'Other'];
  String? selectedCategory;
  String? selectedState;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.updateCategory;
    selectedState = widget.updateState;
    selectedGender = widget.updateGender;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              color: Colors.black12,
              width: 2.0,
            ),
          ),
        ),
        elevation: 1,
        isExpanded: true,
        borderRadius: BorderRadius.circular(15),
        icon: const Icon(Icons.arrow_drop_down),
        menuMaxHeight: 300,
        value: widget.listSelect ? selectedCategory : selectedState,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required field';
          }
          return null;
        },
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
        hint: Text(
          widget.hintText ?? '',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0x66000000),
            fontWeight: FontWeight.w500,
          ),
        ),
        items: widget.listSelect
            ? categoryList.map((newValue) {
                return DropdownMenuItem(
                  value: newValue,
                  child: Text(newValue),
                );
              }).toList()
            : stateList.map((newValue) {
                return DropdownMenuItem(
                  value: newValue,
                  child: Text(newValue),
                );
              }).toList(),
        onChanged: (newValue) {
          widget.listSelect
              ? setState(() {
                  selectedCategory = newValue.toString();
                  debugPrint(selectedCategory);
                  widget.onCategorySelectionChange!(selectedCategory);
                })
              : setState(() {
                  selectedState = newValue.toString();
                  debugPrint(selectedState);
                  widget.onStateCelectionChange!(selectedState);
                });
        },
      ),
    );
  }
}
