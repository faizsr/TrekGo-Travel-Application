import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/service/database_service.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/cards/place_cards.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';

class PopularPlacesScreen extends StatefulWidget {
  final bool? isAdmin;
  final bool? isUser;
  final String? userId;
  final String? sortName;
  const PopularPlacesScreen({
    super.key,
    this.isAdmin,
    this.isUser,
    required this.userId,
    this.sortName,
  });

  @override
  State<PopularPlacesScreen> createState() => _PopularPlacesScreenState();
}

class _PopularPlacesScreenState extends State<PopularPlacesScreen> {
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
          title: 'Popular Destinations',
        ),
      ),

      // ===== Body =====
      body: SingleChildScrollView(
        // ===== Popular places =====
        child: StreamBuilder(
          // ===== Sorting data based on chip selection =====
          stream: widget.sortName == 'View All'
              ? DatabaseService()
                  .destinationCollection
                  .where('place_category', isEqualTo: 'Popular')
                  .snapshots()
              : DatabaseService()
                  .destinationCollection
                  .where('place_category', isEqualTo: 'Popular')
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
                      placeid: destinationSnap.id,
                      placeName: destinationSnap['place_name'],
                      popularCardImage: destinationSnap['place_image'],
                      placeCategory: destinationSnap['place_category'],
                      placeState: destinationSnap['place_state'],
                      ratingCount: ratingCount,
                      placeDescripton: destinationSnap['place_description'],
                      placeLocation: destinationSnap['place_location'],
                      placeMap: destinationSnap['place_map'],
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
