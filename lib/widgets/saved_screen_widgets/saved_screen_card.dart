import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:provider/provider.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/model/saved.dart';
import 'package:trekmate_project/screens/Admin/update_place_screen.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/place_detail_screen.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/custom_alert.dart';
import 'package:trekmate_project/widgets/reusable_widgets/card_rating_bar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/place_card_buttons.dart';
// import 'package:trekmate_project/widgets/saved_icon.dart';
import 'package:trekmate_project/widgets/saved_screen_widgets/saved_screen_icon.dart';
// import 'package:trekmate_project/widgets/saved_provider.dart';

class SavedScreenCard extends StatefulWidget {
  final String? userId;
  final String? placeid;
  final String? popularCardImage;
  final String? placeCategory;
  final String? placeState;
  final String? placeName;
  final String? placeDescripton;
  final String? placeLocation;
  final String? placeMap;
  final double? ratingCount;
  final bool? isAdmin;
  final bool? isUser;
  final int? index;
  final DocumentSnapshot? destinationSnapshot;
  const SavedScreenCard({
    super.key,
    required this.userId,
    this.placeid,
    this.popularCardImage,
    this.placeCategory,
    this.placeState,
    this.placeName,
    this.ratingCount,
    this.placeDescripton,
    this.placeLocation,
    this.placeMap,
    this.isAdmin,
    this.isUser,
    this.destinationSnapshot,
    this.index,
  });

  @override
  State<SavedScreenCard> createState() => _SavedScreenCardState();
}

class _SavedScreenCardState extends State<SavedScreenCard> {
  late Box<Saved> savedBox;
  bool showShimmer = true;

  @override
  void initState() {
    super.initState();
    savedBox = Hive.box('saved');
    Timer(const Duration(milliseconds: 750), () {
      if (mounted) {
        setState(() {
          showShimmer = false;
        });
      }
    });
    debugPrint('user on saved card ${widget.userId}');
  }

  @override
  Widget build(BuildContext context) {
    // var savedProvider = Provider.of<SavedProvider>(context);

    return GestureDetector(
      onTap: () {
        debugPrint('Admin logged place in ${widget.isAdmin}');
        debugPrint('User logged in ${widget.isUser}');
        nextScreen(
          context,
          PlaceDetailScreen(
            userId: widget.userId,
            isAdmin: widget.isAdmin ?? true,
            isUser: widget.isUser ?? false,
            placeid: widget.placeid,
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
                        widget.placeName?.replaceAll(RegExp(r'\s+'), ' ') ?? '',
                        style: const TextStyle(
                          color: Color(0xFF1285b9),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                  child:
                  //  showShimmer
                  //     ? SizedBox(
                  //         width: MediaQuery.of(context).size.width * 0.88,
                  //         height: MediaQuery.of(context).size.height * 0.244,
                  //         child: Image(
                  //           image: AssetImage(lazyLoading),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       )
                  //     :
                       SizedBox(
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: MediaQuery.of(context).size.height * 0.244,
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Image.asset(
                              lazyLoading,
                              fit: BoxFit.cover,
                            ),
                            imageUrl: widget.popularCardImage ?? '',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Image.asset(
                              lazyLoading,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              widget.isAdmin == true
                  ? Positioned(
                      top: 20,
                      left: 20,
                      child: GestureDetector(
                          onTap: () => nextScreen(
                                context,
                                UpdatePlaceScreen(
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
                child: SavedScreenIcon(
                  index: widget.index,
                  id: widget.placeid,
                  image: widget.popularCardImage,
                  rating: widget.ratingCount,
                  name: widget.placeName,
                  description: widget.placeDescripton,
                  location: widget.placeLocation,
                  // isSaved: savedProvider.isExist(widget.placeid ?? ''),
                ),
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
    builder: (context) {
      return CustomAlertDialog(
        title: 'Delete Place?',
        description: 'This place will be permanently deleted from this list',
        onTap: () async {
          await DatabaseService().destinationCollection.doc(placeId).delete();
          debugPrint('Deleted successfully');
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        },
      );
    },
  );
}
