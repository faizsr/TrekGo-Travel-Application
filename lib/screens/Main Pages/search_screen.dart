import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/resent_search_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Appbar =====
          Container(
            height: MediaQuery.of(context).size.height * 0.235,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              color: Color(0xFFe5e6f6),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  // ===== Appbar heading and icons =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Where do you \nwanna go?',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1285b9),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.098,
                        height: MediaQuery.of(context).size.height * 0.048,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1285b9),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.person_2_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // ===== Appbar search area =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextFieldWidget(
                        colorIsWhite: true,
                        noPaddingNeeded: true,
                        fieldHintText: 'Search here...',
                      ),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                offset: Offset(0, 2),
                                color: Color(0x0D000000),
                              )
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * 0.14,
                          height: MediaQuery.of(context).size.height * 0.0625,
                          child: const Icon(FeatherIcons.search),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          // ===== Recent search area =====
          const Padding(
            padding: EdgeInsets.only(
              left: 25,
              top: 15,
              bottom: 8,
            ),
            child: Text(
              'Recent search',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),

          // ===== Recent search card =====
          RecentSearchCard(
            cardImage: maharajaPalace,
            cardTitle: 'Maharaja Palace',
          ),
          RecentSearchCard(
            cardImage: munnar,
            cardTitle: 'Munnar View Point',
          ),
          RecentSearchCard(
            cardImage: kuttanad,
            cardTitle: 'Kuttand',
          ),
          RecentSearchCard(
            cardImage: nandiHills,
            cardTitle: 'Nandi Hills',
          ),
        ],
      ),
    );
  }
}
