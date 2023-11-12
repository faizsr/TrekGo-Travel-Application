import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/Admin/update_place_screen.dart';
import 'package:trekmate_project/screens/Main%20Pages/Sub%20pages/place_detail_screen.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/reusable_widgets/card_rating_bar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/place_card_buttons.dart';
import 'package:trekmate_project/widgets/saved_icon.dart';

class PopularCard extends StatelessWidget {
  final String? placeid;
  final String popularCardImage;
  final String? placeCategory;
  final String? placeState;
  final String? placeName;
  final String? placeDescripton;
  final String? placeLocation;
  final double? ratingCount;
  final bool? isAdmin;
  final bool? isUser;
  final DocumentSnapshot? destinationSnapshot;
  const PopularCard({
    super.key,
    this.placeid,
    required this.popularCardImage,
    this.placeCategory,
    this.placeState,
    this.placeName,
    this.ratingCount,
    this.placeDescripton,
    this.placeLocation,
    this.isAdmin,
    this.isUser,
    this.destinationSnapshot,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('Admin logged place in $isAdmin');
        debugPrint('User logged in $isUser');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(
              isAdmin: isAdmin ?? true,
              isUser: isUser ?? false,
              placeid: placeid,
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 2,
                color: Color(0x0D000000),
              )
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.88,
          height: MediaQuery.of(context).size.height / 2.95,
          child: Stack(
            children: [
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.01,
                left: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // color: Colors.black,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        placeName ?? '',
                        style: const TextStyle(
                            color: Color(0xFF1285b9),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    CardRatingBar(
                      ratingCount: ratingCount ?? 0,
                      itemSize: 20,
                      isRatingTextNeeded: true,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 2,
                        top: 2,
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      color: Color(0x0D000000),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: Image(
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child;
                        } else {
                          return AnimatedOpacity(
                            opacity: frame == null ? 0 : 1,
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeOut,
                            child: child,
                          );
                        }
                      },
                      image: NetworkImage(
                        popularCardImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              isAdmin == true
                  ? Positioned(
                      top: 20,
                      left: 20,
                      child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdatePlaceScreen(
                                    placeid: placeid,
                                    placeImage: popularCardImage,
                                    placeCategory: placeCategory,
                                    placeState: placeState,
                                    placeTitle: placeName,
                                    placeDescription: placeDescripton,
                                    placeLocation: placeLocation,
                                    placeRating: ratingCount,
                                  ),
                                ),
                              ),
                          child: const PlaceCardButton(buttonText: 'UPDATE')),
                    )
                  : const SizedBox(),
              isAdmin == true
                  ? Positioned(
                      top: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          deleteData(placeid ?? '');
                        },
                        child: const PlaceCardButton(buttonText: 'REMOVE'),
                      ),
                    )
                  : const SizedBox(),
              Positioned(
                right: 30,
                bottom: MediaQuery.of(context).size.width * 0.16,
                child: const SavedIcon(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> deleteData(String placeid) async {
  await DatabaseService().destinationCollection.doc(placeid).delete();
}
