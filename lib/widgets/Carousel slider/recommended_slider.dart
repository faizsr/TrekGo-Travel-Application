import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/recommended_card.dart';

class RecommendedPlaceSlider extends StatefulWidget {
  final String? sortName;
  const RecommendedPlaceSlider({
    super.key,
    this.sortName,
  });

  @override
  State<RecommendedPlaceSlider> createState() => _RecommendedPlaceSliderState();
}

class _RecommendedPlaceSliderState extends State<RecommendedPlaceSlider> {
  double? ratingCount;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          top: 15,
        ),
        child: StreamBuilder(
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
              return Row(
                children: snapshot.data.docs
                    .map<Widget>((DocumentSnapshot destinationSnap) {
                  ratingCount = double.tryParse(
                      destinationSnap['place_rating'].toString());
                  return RecommendedCard(
                    placeName: destinationSnap['place_name'],
                    ratingCount: double.tryParse(
                        destinationSnap['place_rating'].toString()),
                    recommendedCardImage: destinationSnap['place_image'],
                    placeDescription: destinationSnap['place_description'],
                    placeLocation: destinationSnap['place_location'],
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
