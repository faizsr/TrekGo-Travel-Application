import 'package:flutter/material.dart';

class ChoiceChipsWidget extends StatefulWidget {
  const ChoiceChipsWidget({
    super.key,
  });

  @override
  State<ChoiceChipsWidget> createState() => _ChoiceChipsWidgetState();
}

class _ChoiceChipsWidgetState extends State<ChoiceChipsWidget> {
  int selectedOption = 0;
  List<bool>? isSelected;
  int? noOfButtons;
  String? sortName;

  List<String> buttonText = [
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 15, ),
            scrollDirection: Axis.horizontal,
            itemCount: buttonText.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    // height: 36,
                    height: MediaQuery.of(context).size.height * 0.0415,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: Offset(0, 2),
                          color: Color(0x1A000000),
                        ),
                      ],
                    ),
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
                  ),
                  const SizedBox(
                    width: 14,
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
