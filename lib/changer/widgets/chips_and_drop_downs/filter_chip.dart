import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

class FilterChipWidget extends StatefulWidget {
  final List<String>? selectedState;
  final String? category;
  final VoidCallback? onUpdateData;
  final bool? isSelectedFilter;
  const FilterChipWidget({
    super.key,
    this.selectedState,
    this.category,
    this.onUpdateData,
    this.isSelectedFilter,
  });

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelectedFilter!;
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0xFF696a71));
    return FilterChip(
        color: MaterialStateProperty.all(Colors.white),
        pressElevation: 0,
        labelStyle: const TextStyle(color: Colors.black),
        selectedColor: const Color(0xFFe5e6f6),
        backgroundColor: Colors.transparent.withOpacity(0),
        showCheckmark: false,
        selected: widget.selectedState != null &&
            widget.selectedState!.contains(widget.category?.toLowerCase()),
        label: Text(widget.category ?? ''),
        onSelected: (selected) {
          setState(() {
            isSelected = !isSelected;
            debugPrint('is selected: $isSelected');
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
