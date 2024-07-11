import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class FilterButtonList extends StatefulWidget {
  final void Function(String?)? onSortNameChanged;
  const FilterButtonList({
    super.key,
    this.onSortNameChanged,
  });

  @override
  State<FilterButtonList> createState() => _FilterButtonListState();
}

class _FilterButtonListState extends State<FilterButtonList> {
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
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: 80,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: buttonText.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ChoiceChip(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              showCheckmark: false,
              elevation: 0,
              backgroundColor: AppColors.white,
              label: Text(
                buttonText[index],
                style: TextStyle(
                  color:
                      isSelected![index] ? AppColors.white : AppColors.darkTeal,
                  fontSize: 13,
                ),
              ),
              selectedColor: AppColors.darkTeal,
              selected: isSelected![index],
              onSelected: (active) {
                setState(() {
                  chipSelectionHandle(index);
                  sortName = buttonText[index];
                  widget.onSortNameChanged!(sortName);
                });
              },
              materialTapTargetSize: MaterialTapTargetSize.padded,
              shape: StadiumBorder(
                side: BorderSide(
                  style: BorderStyle.solid,
                  color: AppColors.darkTeal,
                  width: 1.5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
