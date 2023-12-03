import 'package:flutter/material.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';

class FilterChipWidget extends StatefulWidget {
  final List<String>? selectedState;
  final String? category;
  final VoidCallback? onUpdateData;
  const FilterChipWidget({
    super.key,
    this.selectedState,
    this.category,
    this.onUpdateData,
  });

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0xFF696a71));
    return FilterChip(
        labelStyle: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1485b9)),
        // side: const BorderSide(width: 2, color: Color(0xFF1485b9)),
        selectedColor: const Color(0xFF1485b9),
        backgroundColor: Colors.white,
        showCheckmark: false,
        selected: widget.selectedState != null &&
            widget.selectedState!.contains(widget.category?.toLowerCase()),
        label: Text(widget.category ?? ''),
        onSelected: (selected) {
          setState(() {
            isSelected = !isSelected;
            if (selected) {
              widget.selectedState!.add(widget.category!.toLowerCase());
            } else {
              widget.selectedState!.remove(widget.category?.toLowerCase());
            }
          });
          debugPrint('selected state: ${widget.selectedState}');

          widget.onUpdateData?.call();
        });
  }

  @override
  void dispose() {
    resetStatusBarColor();
    super.dispose();
  }
}
