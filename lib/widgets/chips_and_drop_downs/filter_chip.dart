import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return FilterChip(
        showCheckmark: false,
        selected:
            widget.selectedState!.contains(widget.category?.toLowerCase()),
        label: Text(widget.category ?? ''),
        onSelected: (selected) {
          setState(() {
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
}
