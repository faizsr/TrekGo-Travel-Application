import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/changer/service/database_service.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/cards/place_cards.dart';

class PopularCarouselSlider extends StatefulWidget {
  final bool? isAdmin;
  final bool? isUser;
  final String? userId;
  final String? sortName;
  const PopularCarouselSlider({
    super.key,
    this.isAdmin,
    this.isUser,
    this.userId,
    this.sortName,
  });

  @override
  State<PopularCarouselSlider> createState() => _PopularCarouselSliderState();
}

class _PopularCarouselSliderState extends State<PopularCarouselSlider> {
  @override
  void initState() {
    super.initState();
    debugPrint(widget.sortName);
  }

  @override
  Widget build(BuildContext context) {
    // ===== Popular places carousel slider =====
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.7,
      child: StreamBuilder(
        stream: widget.sortName == 'View All'
            ? FirebaseFirestore.instance
                .collection('destination')
                .where('place_category', isEqualTo: 'Popular')
                .snapshots()
            : DatabaseService()
                .destinationCollection
                .where('place_category', isEqualTo: 'Popular')
                .where('place_state', isEqualTo: widget.sortName)
                .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.88,
              height: MediaQuery.of(context).size.height / 2.7,
              margin: const EdgeInsets.only(top: 20, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: const Color(0xFF1485b9),
                  size: 35,
                ),
              ),
            );
          }

          if (snapshot.hasData && snapshot.data.docs.length > 0) {
            // widget.onSortNameChanged;
            return CarouselSlider.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index, realIndex) {
                  DocumentSnapshot destinationSnapshot =
                      snapshot.data.docs[index];
                  return PopularCard(
                    userId: widget.userId,
                    isAdmin: widget.isAdmin == true ? null : widget.isAdmin,
                    isUser: widget.isUser,
                    placeid: destinationSnapshot.id,
                    popularCardImage: destinationSnapshot['place_image'],
                    placeCategory: destinationSnapshot['place_category'],
                    placeState: destinationSnapshot['place_state'],
                    placeName: destinationSnapshot['place_name'],
                    ratingCount: double.tryParse(
                        destinationSnapshot['place_rating'].toString()),
                    placeDescripton: destinationSnapshot['place_description'],
                    placeLocation: destinationSnapshot['place_location'],
                    placeMap: destinationSnapshot['place_map'],
                  );
                },
                options: CarouselOptions(
                  // autoPlay: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  viewportFraction: 1.0,
                  pauseAutoPlayInFiniteScroll: true,
                  height: MediaQuery.of(context).size.height / 2.95,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                ));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width * 0.88,
              height: MediaQuery.of(context).size.height / 2.7,
              margin: const EdgeInsets.only(top: 20, bottom: 15),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                    color: Color(0x0D000000),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Image.asset(searchNoResult),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    'No Popular Destinations Found In \n"${widget.sortName}"',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF1285b9),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
