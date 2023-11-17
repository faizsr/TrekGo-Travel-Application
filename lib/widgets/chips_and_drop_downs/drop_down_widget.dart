import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  final String? hintText;
  final String? updateCategory;
  final String? updateState;
  final double? leftPadding;
  final double? rightPadding;
  final bool listSelect;
  final Function(String?)? onCategorySelectionChange;
  final Function(String?)? onStateCelectionChange;
  final String? Function(String?)? validator;
  const DropDownWidget({
    super.key,
    this.hintText,
    this.updateCategory,
    this.updateState,
    this.leftPadding,
    this.rightPadding,
    this.listSelect = false,
    this.onCategorySelectionChange,
    this.onStateCelectionChange,
    this.validator,
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
  String? selectedCategory;
  String? selectedState;

  @override
  void initState() {
    super.initState();
    debugPrint('Category : ${widget.updateCategory}');
    debugPrint('State : ${widget.updateState}');
    selectedCategory = widget.updateCategory;
    selectedState = widget.updateState;
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
        value: widget.listSelect ? selectedCategory : selectedState,
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
