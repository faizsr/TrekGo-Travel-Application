import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trekgo_project/changer/service/database_service.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/cards/recommended_card.dart';
import 'package:trekgo_project/changer/assets.dart';

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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: MediaQuery.of(context).size.width / 2.3,
                height: MediaQuery.of(context).size.height / 4.3,
                margin: const EdgeInsets.only(top: 20, bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: LoadingAnimationWidget.threeArchedCircle(
                    color: const Color(0xFF1485b9),
                    size: 30,
                  ),
                ),
              );
            }
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
              return Container(
                width: MediaQuery.of(context).size.width / 2.3,
                height: MediaQuery.of(context).size.height / 4.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                      color: Color(0x0D000000),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Image.asset(searchNoResult),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      'No Destinations Found In \n"${widget.sortName}"',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1285b9),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
