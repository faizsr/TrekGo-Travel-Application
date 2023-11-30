import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/cards/place_cards.dart';

class RecommendedPlacesScreen extends StatefulWidget {
  final bool? isAdmin;
  final bool? isUser;
  final String? userId;
  final String? sortName;
  const RecommendedPlacesScreen({
    super.key,
    this.sortName,
    this.isAdmin,
    required this.userId,
    this.isUser,
  });

  @override
  State<RecommendedPlacesScreen> createState() =>
      _RecommendedPlacesScreenState();
}

class _RecommendedPlacesScreenState extends State<RecommendedPlacesScreen> {
  double? ratingCount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Appbar =====
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.12,
        child: PlaceScreenAppbar(
          sortName: widget.sortName,
          title: 'Recommended',
        ),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        // ===== Recommended places =====
        child: StreamBuilder(
          // ===== Sorting data based on chip selection =====
          stream: widget.sortName == 'View All'
              ? DatabaseService()
                  .destinationCollection
                  .where('place_category', isEqualTo: 'Recommended')
                  .snapshots()
              : DatabaseService()
                  .destinationCollection
                  .where('place_category', isEqualTo: 'Recommended')
                  .where('place_state', isEqualTo: widget.sortName)
                  .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data.docs
                    .map<Widget>((DocumentSnapshot destinationSnap) {
                  ratingCount = double.tryParse(
                      destinationSnap['place_rating'].toString());
                  return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: PopularCard(
                      userId: widget.userId,
                      isAdmin: widget.isAdmin,
                      isUser: widget.isUser,
                      ratingCount: ratingCount,
                      placeid: destinationSnap.id,
                      placeCategory: destinationSnap['place_category'],
                      placeState: destinationSnap['place_state'],
                      placeName: destinationSnap['place_name'],
                      popularCardImage: destinationSnap['place_image'],
                      placeDescripton: destinationSnap['place_description'],
                      placeLocation: destinationSnap['place_location'],
                    ),
                  );
                }).toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
