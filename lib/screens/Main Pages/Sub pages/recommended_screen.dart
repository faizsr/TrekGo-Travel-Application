import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/place_cards.dart';

class RecommendedPlacesScreen extends StatelessWidget {
  const RecommendedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(top: 18),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: [
              const Text(
                'Recommended',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.mapMarkerOutline,
                      size: 12,
                      color: Colors.black,
                    ),
                    const Text(
                      'Kerala, India',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: const Color(0xFFe5e6f6),
      ),

      //Body
      body: SingleChildScrollView(
        //Recommended place cards
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: PopularCard(
                popularCardImage: munnar,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: PopularCard(
                popularCardImage: kuttanad,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: PopularCard(
                popularCardImage: athirapally,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: PopularCard(
                popularCardImage: jewTown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
