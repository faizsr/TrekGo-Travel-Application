import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/Admin/update_place_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/place_detail_screen.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/reusable_widgets/card_rating_bar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/place_card_buttons.dart';
import 'package:trekmate_project/widgets/saved_icon.dart';

class PopularCard extends StatefulWidget {
  final String? placeid;
  final String? popularCardImage;
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
    this.popularCardImage,
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
  State<PopularCard> createState() => _PopularCardState();
}

class _PopularCardState extends State<PopularCard> {
  bool showShimmer = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 750), () {
      if (mounted) {
        setState(() {
          showShimmer = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('Admin logged place in ${widget.isAdmin}');
        debugPrint('User logged in ${widget.isUser}');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaceDetailScreen(
              isAdmin: widget.isAdmin ?? true,
              isUser: widget.isUser ?? false,
              placeid: widget.placeid,
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
                        widget.placeName ?? '',
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
                      ratingCount: widget.ratingCount ?? 0,
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
                  child: showShimmer
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: MediaQuery.of(context).size.height * 0.24,
                          child: Image(
                            image: AssetImage(lazyLoading),
                            fit: BoxFit.cover,
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: MediaQuery.of(context).size.height * 0.24,
                          child: FadeInImage(
                            placeholder: AssetImage(lazyLoading),
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.popularCardImage ?? ''),
                          ),
                        ),
                ),
              ),
              widget.isAdmin == true
                  ? Positioned(
                      top: 20,
                      left: 20,
                      child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdatePlaceScreen(
                                    placeid: widget.placeid,
                                    placeImage: widget.popularCardImage,
                                    placeCategory: widget.placeCategory,
                                    placeState: widget.placeState,
                                    placeTitle: widget.placeName,
                                    placeDescription: widget.placeDescripton,
                                    placeLocation: widget.placeLocation,
                                    placeRating: widget.ratingCount,
                                  ),
                                ),
                              ),
                          child: const PlaceCardButton(buttonText: 'UPDATE')),
                    )
                  : const SizedBox(),
              widget.isAdmin == true
                  ? Positioned(
                      top: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          deleteDestination(widget.placeid ?? '', context);
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

Future<T?> deleteDestination<T>(String placeId, BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure want to delete'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () async {
            await DatabaseService().destinationCollection.doc(placeId).delete();
            debugPrint('Deleted successfully');
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        )
      ],
    ),
  );
}
