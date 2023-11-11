import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/place_cards.dart';

class RecommendedPlacesScreen extends StatefulWidget {
  final bool? isAdmin;
  final bool? isUser;
  final String? sortName;
  const RecommendedPlacesScreen({
    super.key,
    this.sortName,
    this.isAdmin,
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
