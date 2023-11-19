import 'package:flutter/material.dart';

class FirebaseFilterChipWidget extends StatefulWidget {
  final List<String>? selectedState;
  final String? category;
  final VoidCallback? onUpdateData;
  const FirebaseFilterChipWidget({
    super.key,
    this.selectedState,
    this.category,
    this.onUpdateData,
  });

  @override
  State<FirebaseFilterChipWidget> createState() =>
      _FirebaseFilterChipWidgetState();
}

class _FirebaseFilterChipWidgetState extends State<FirebaseFilterChipWidget> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
        showCheckmark: false,
        selected: widget.selectedState != null &&
            widget.selectedState!.contains(widget.category),
        label: Text(widget.category ?? ''),
        onSelected: (selected) {
          setState(() {
            if (selected) {
              widget.selectedState!.add(widget.category!);
            } else {
              widget.selectedState!.remove(widget.category);
            }
          });
          debugPrint('selected state: ${widget.selectedState}');

          widget.onUpdateData?.call();
        });
  }
}
