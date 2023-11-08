import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/place_cards.dart';

class PopularCarouselSlider extends StatefulWidget {
  final String? sortName;
  const PopularCarouselSlider({super.key, this.sortName});

  @override
  State<PopularCarouselSlider> createState() => _PopularCarouselSliderState();
}

class _PopularCarouselSliderState extends State<PopularCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.7,
      child: StreamBuilder(
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
          if (snapshot.hasData && snapshot.data.docs.length > 0) {
            // widget.onSortNameChanged;
            return CarouselSlider.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index, realIndex) {
                  DocumentSnapshot destinationSnapshot =
                      snapshot.data.docs[index];
                  return PopularCard(
                    popularCardImage: destinationSnapshot['place_image'],
                    placeName: destinationSnapshot['place_name'],
                    ratingCount: double.tryParse(
                        destinationSnapshot['place_rating'].toString()),
                    placeDescripton: destinationSnapshot['place_description'],
                    placeLocation: destinationSnapshot['place_location'],
                  );
                },
                options: CarouselOptions(
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
              color: Colors.white,
              height: MediaQuery.of(context).size.height / 2.7,
              child: const Center(
                child: Text('Popular is empty for this place'),
              ),
            );
          }
        },
      ),
    );
  }
}
