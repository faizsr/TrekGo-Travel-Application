import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/reusable_widgets/recommended_card.dart';

class RecommendedPlaceSlider extends StatefulWidget {
  final String? sortName;
  final bool? isAdmin;
  final bool? isUser;
  final String? userId;
  const RecommendedPlaceSlider({
    super.key,
    this.sortName,
    this.isAdmin,
    this.isUser,
    required this.userId,
  });

  @override
  State<RecommendedPlaceSlider> createState() => _RecommendedPlaceSliderState();
}

class _RecommendedPlaceSliderState extends State<RecommendedPlaceSlider> {
  double? ratingCount;
  @override
  Widget build(BuildContext context) {
    // ===== Recommended places carousel slider =====
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
            if (snapshot.hasData && snapshot.data.docs.length > 0) {
              return Row(
                children: snapshot.data.docs
                    .map<Widget>((DocumentSnapshot destinationSnap) {
                  ratingCount = double.tryParse(
                      destinationSnap['place_rating'].toString());
                  return RecommendedCard(
                    userId: widget.userId ?? '',
                    isAdmin: widget.isAdmin == true ? null : widget.isAdmin,
                    isUser: widget.isUser,
                    placeName: destinationSnap['place_name'],
                    ratingCount: double.tryParse(
                        destinationSnap['place_rating'].toString()),
                    placeid: destinationSnap.id,
                    placeCategory: destinationSnap['place_category'],
                    placeState: destinationSnap['place_state'],
                    recommendedCardImage: destinationSnap['place_image'],
                    placeDescription: destinationSnap['place_description'],
                    placeLocation: destinationSnap['place_location'],
                  );
                }).toList(),
              );
            } else {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2.2,
                height: MediaQuery.of(context).size.height / 5.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage(lazyLoading),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
