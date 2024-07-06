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
    debugPrint('Category : ${widget.updateCategory}');
    debugPrint('State : ${widget.updateState}');
    selectedCategory = widget.updateCategory;
    selectedState = widget.updateState;
    selectedGender = widget.updateGender;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: widget.leftPadding ?? 20, right: widget.rightPadding ?? 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
        border: Border.all(width: 2, color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: EdgeInsets.only(
            left: widget.iconLeftPadding ?? 15,
            right: widget.iconRightPadding ?? 15,
          ),
          child: DropdownButton(
            elevation: 2,
            isExpanded: widget.isExpanded ?? false,
            borderRadius: BorderRadius.circular(20),
            icon: const Icon(Icons.arrow_drop_down),
            menuMaxHeight: 300,
            value: widget.listSelect ? selectedCategory : selectedState,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            // validator: widget.validator,
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
        ),
      ),
    );
  }
}
