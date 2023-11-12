import 'package:flutter/material.dart';
import 'package:trekmate_project/widgets/saved_icon.dart';

class SavedPlacesScreen extends StatelessWidget {
  const SavedPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Appbar =====
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFe5e6f6),
              ),
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Text(
                        'Saved Places',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1285b9),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: SizedBox(
                        width: 60,
                        height: 65,
                        child: SavedIcon(biggerIcon: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===== Saved places card =====

            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: PopularCard(popularCardImage: varkala),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: PopularCard(popularCardImage: athirapally),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: PopularCard(popularCardImage: munnar),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: PopularCard(popularCardImage: cubbonPark),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: PopularCard(popularCardImage: maharajaPalace),
            // ),
            const Text('No saved places'),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
            )
          ],
        ),
      ),
    );
  }
}
