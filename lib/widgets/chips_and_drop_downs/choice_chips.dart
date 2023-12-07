import 'package:flutter/material.dart';

class ChoiceChipsWidget extends StatefulWidget {
  final void Function(String?)? onSortNameChanged;
  const ChoiceChipsWidget({
    super.key,
    this.onSortNameChanged,
  });

  @override
  State<ChoiceChipsWidget> createState() => _ChoiceChipsWidgetState();
}

class _ChoiceChipsWidgetState extends State<ChoiceChipsWidget> {
  int selectedOption = 0;
  bool? viewAll;
  List<bool>? isSelected;
  int? noOfButtons;
  String? sortName;

  List<String> buttonText = [
    'View All',
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

  void chipSelectionHandle(int index) {
    setState(() {
      for (int i = 0; i < noOfButtons!; i++) {
        isSelected![i] = (i == index);
      }
    });
  }

  @override
  void initState() {
    noOfButtons = buttonText.length;
    isSelected = List.filled(noOfButtons!, false);
    isSelected![selectedOption] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: buttonText.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 13),
            child: ChoiceChip(
              backgroundColor: Colors.white,
              label: Text(
                buttonText[index],
                style: TextStyle(
                  color: isSelected![index]
                      ? Colors.white
                      : const Color(0xFF1285b9),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              selectedColor: const Color(0xFF1285b9),
              selected: isSelected![index],
              onSelected: (active) {
                setState(() {
                  chipSelectionHandle(index);
                  sortName = buttonText[index];
                  // viewAll = sortName == null;
                  widget.onSortNameChanged!(sortName);
                });
              },
              elevation: 0.0,
              shadowColor: Colors.transparent.withOpacity(0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: StadiumBorder(
                side: BorderSide(
                  color: isSelected![index]
                      ? Colors.white
                      : const Color(0xFF1285b9),
                  width: 2.5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
