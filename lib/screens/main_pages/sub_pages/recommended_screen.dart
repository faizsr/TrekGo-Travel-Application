import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/service/database_service.dart';
import 'package:trekgo_project/widgets/reusable_widgets/cards/place_cards.dart';
import 'package:trekgo_project/widgets/reusable_widgets/reusable_widgets.dart';

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
        preferredSize: MediaQuery.of(context).size * 0.105,
        child: CustomAppbar(
          iconPadding: 25,
          titlePadding: 20,
          toolBarHeight: 80,
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
                  .where('category', isEqualTo: 'Recommended')
                  .snapshots()
              : DatabaseService()
                  .destinationCollection
                  .where('category', isEqualTo: 'Recommended')
                  .where('state', isEqualTo: widget.sortName)
                  .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: snapshot.data.docs
                    .map<Widget>((DocumentSnapshot destinationSnap) {
                  ratingCount = double.tryParse(
                      destinationSnap['rating'].toString());
                  return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: PopularCard(
                      userId: widget.userId,
                      isAdmin: widget.isAdmin,
                      isUser: widget.isUser,
                      ratingCount: ratingCount,
                      placeid: destinationSnap.id,
                      placeCategory: destinationSnap['category'],
                      placeState: destinationSnap['state'],
                      placeName: destinationSnap['name'],
                      popularCardImage: destinationSnap['image'],
                      placeDescripton: destinationSnap['description'],
                      placeLocation: destinationSnap['location'],
                      placeMap: destinationSnap['map'],
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
