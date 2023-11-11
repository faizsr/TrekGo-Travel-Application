import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/favorite_card_all.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ===== Appbar =====
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Icon(
              Icons.keyboard_backspace_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Your Favorites',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: const Color(0xFFe5e6f6),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              FavoriteCardAll(
                backgroundImage: cubbonPark,
                placeName: 'Cubbon Park',
              ),
              FavoriteCardAll(
                backgroundImage: athirapally,
                placeName: 'Athirapally Falls',
              ),
              FavoriteCardAll(
                backgroundImage: maharajaPalace,
                placeName: 'Mysore Maharaja Palace',
              ),
              FavoriteCardAll(
                backgroundImage: hampi,
                placeName: 'Hampi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
