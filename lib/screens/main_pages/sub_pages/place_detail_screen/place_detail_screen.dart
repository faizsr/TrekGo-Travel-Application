import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/assets.dart';
import 'package:trekgo_project/screens/admin/widgets/add_place_rating_widget.dart';
import 'package:trekgo_project/screens/main_pages/sub_pages/place_detail_screen/widgets/appbar.dart';
import 'package:trekgo_project/service/database_service.dart';
import 'package:trekgo_project/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/screens/user/widget/widgets.dart';
import 'package:trekgo_project/screens/main_pages/sub_pages/place_detail_screen/widgets/overview_buttons.dart';
import 'package:trekgo_project/screens/main_pages/sub_pages/place_detail_screen/widgets/overview_tabview.dart';
import 'package:trekgo_project/screens/main_pages/sub_pages/place_detail_screen/widgets/review_section_text_field.dart';
import 'package:trekgo_project/screens/main_pages/sub_pages/place_detail_screen/widgets/reviews.dart';
import 'package:trekgo_project/widgets/reusable_widgets/reusable_widgets.dart';

class PlaceDetailScreen extends StatefulWidget {
  final String? placeid;
  final bool? isAdmin;
  final bool? isUser;
  final String? userId;
  final String? searchImage;
  final String? searchName;
  final String? searchDescription;
  final String? searchLocation;
  final String? searchMap;
  final double? searchRating;
  final bool isSearch;
  const PlaceDetailScreen({
    super.key,
    this.placeid,
    this.isAdmin,
    this.isUser,
    this.userId,
    this.searchImage,
    this.searchName,
    this.searchDescription,
    this.searchLocation,
    this.searchMap,
    this.searchRating,
    this.isSearch = false,
  });

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen>
    with TickerProviderStateMixin {
  late Stream<DocumentSnapshot> _destinationData;
  late Stream<DocumentSnapshot> userDataStream;

  late TabController tabController;

  String? name;
  double? ratingCount;
  double? addedRating;
  String? userId;
  String? userName;
  String? userProfile;

  @override
  void initState() {
    super.initState();
    _destinationData =
        DatabaseService().getdestinationData(widget.placeid ?? '');
    userDataStream = DatabaseService().getUserDetails(widget.userId ?? '');

    name = FirebaseAuth.instance.currentUser!.email;
    userId = FirebaseAuth.instance.currentUser!.uid;
    debugPrint('user name: $name');
    tabController = TabController(length: 3, vsync: this);
  }

  void updateRatingCount(double? rating) {
    ratingCount = rating;
    debugPrint('rating count:$ratingCount');
  }

  void addComment({String? reviewText, String? userIdd, String? userProfile}) {
    FirebaseFirestore.instance
        .collection('destination')
        .doc(widget.placeid)
        .collection('reviews')
        .add({
      'reviewText': reviewText,
      'reviewUserId': userIdd,
      'reviewDate': Timestamp.now(),
      'ratingCount': addedRating ?? 3.5,
    });
    debugPrint('Added comment: $reviewText');
    debugPrint('Posted rating on comment $addedRating');
  }

  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0xFFc0f8fe));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,

      // ============ Appbar ============
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.095,
        ),
        child: const PlaceDetailAppbar(),
      ),
      backgroundColor: const Color(0xFFf0f3f7),

      // ============ Body ============
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF0F3F7),
                Color(0xFFC0F8FE),
              ],
              stops: [0.35, 0.77],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: StreamBuilder(
            stream: _destinationData,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data?.data() != null) {
                var destinationSnapshot =
                    snapshot.data?.data() as Map<String, dynamic>;

                String image = destinationSnapshot['image'];
                String category = destinationSnapshot['category'];
                String state = destinationSnapshot['state'];
                String title = destinationSnapshot['name'];
                String description = destinationSnapshot['description'];
                String location = destinationSnapshot['location'];
                double rating = double.parse(destinationSnapshot['rating'].toString());
                String mapLink = destinationSnapshot['map'];

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ============ Place Image ============
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 20,
                          left: 25,
                          right: 25,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.495,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 15,
                              spreadRadius: 2,
                              color: Color(0x0D000000),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: GestureDetector(
                            onTap: () {
                              debugPrint('Tapped');
                              showDialog(
                                context: context,
                                builder: (context) {
                                  // setStatusBarColor(const Color(0xFF577073));
                                  return Dialog(
                                    elevation: 10,
                                    backgroundColor: const Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            lazyLoading,
                                            fit: BoxFit.cover,
                                          ),
                                          imageUrl: destinationSnapshot[
                                                  'image'] ??
                                              '',
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            lazyLoading,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Image.asset(
                                lazyLoading,
                                fit: BoxFit.cover,
                              ),
                              imageUrl:
                                  destinationSnapshot['image'] ?? '',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Image.asset(
                                lazyLoading,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ============ Place Title ============
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.67,
                        child: Text(
                          destinationSnapshot['name']
                              .toString()
                              .replaceAll(RegExp(r'\s+'), ' '),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CardRatingBar(
                        itemSize: 20,
                        isMainAlignCenter: true,
                        ratingCount: double.parse(destinationSnapshot['rating'].toString()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0x0D000000),
                      ),

                      // ============ Tab Bar Heading ============
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.035,
                        child: TabBar(
                          physics: const BouncingScrollPhysics(),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          indicatorWeight: 2,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorPadding: const EdgeInsets.all(0),
                          indicatorColor: const Color(0xFF1285b9),
                          labelColor: const Color(0xFF1285b9),
                          unselectedLabelColor: Colors.grey,
                          controller: tabController,
                          tabs: const [
                            Text(
                              'Overview',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Rate',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                        color: Color(0x0D000000),
                      ),

                      // ============ Tab Bar Views ============
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            // ============= Overview Section =============
                            Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: OverViewSection(
                                    description: description.replaceAll(
                                        RegExp(r'\s+'), ' '),
                                    location: location.replaceAll(
                                        RegExp(r'\s+'), ' '),
                                    mapLink: mapLink,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: OverviewBottomButtons(
                                    isAdmin: widget.isAdmin,
                                    mapLink: mapLink,
                                    image: image,
                                    category: category,
                                    state: state,
                                    title: title,
                                    description: description,
                                    location: location,
                                    rating: rating,
                                    placeId: widget.placeid,
                                    ctx: context,
                                    userId: widget.userId,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),

                            // ============= Rating Section =============
                            Container(
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: 20,
                                top: 10,
                              ),
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: Offset(0, 0),
                                    spreadRadius: 2,
                                    color: Color(0x0D000000),
                                  )
                                ],
                                color: const Color(0xFFf9fafc),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Rate Your Experience With This Destination',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  RatingStarWidget(
                                    initialRatingCount: addedRating ?? 3.5,
                                    onUserRating: true,
                                    unRatedColor: Colors.purple.shade100,
                                    ratedColor: Colors.purple.shade300,
                                    onRatingPlace: updateRatingCount,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: ButtonsWidget(
                                      buttonTextSize: 12,
                                      isOutlinedButton: true,
                                      buttonTxtColor: Colors.purple,
                                      buttonColor: Colors.transparent,
                                      buttonText: 'POST RATING',
                                      buttonOnPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomAlertDialog(
                                              // disableTitle: false,
                                              title: 'Post Rating?',
                                              description:
                                                  'Your review will be only posted only if you add a review.',
                                              descriptionTxtSize: 14,
                                              actionBtnTxt: 'Add review',
                                              onTap: () {
                                                // On tapping changing the tab to review.
                                                tabController.animateTo(2);
                                                setState(() {
                                                  addedRating = ratingCount;
                                                  debugPrint(
                                                      'Rating after posting: ${addedRating ?? 3.5}');
                                                  FirebaseFirestore.instance
                                                      .collection('destination')
                                                      .doc(widget.placeid)
                                                      .collection('reviews')
                                                      .doc()
                                                      .set({
                                                    'user_rating_count':
                                                        addedRating ?? 3.5
                                                  });
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ============= Review Section =============
                            Stack(
                              children: [
                                const Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 45,
                                  child: Divider(
                                    thickness: 1.6,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ReviewTextField(
                                    controller: reviewController,
                                    onTap: () {
                                      String trimmedText =
                                          reviewController.text.trim();
                                      if (trimmedText.isNotEmpty) {
                                        addComment(
                                          reviewText: reviewController.text.trim(),
                                          userIdd: userId,
                                          userProfile: userProfile,
                                        );
                                        reviewController.clear();
                                      }
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 55,
                                  left: 0,
                                  right: 0,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('destination')
                                        .doc(widget.placeid)
                                        .collection('reviews')
                                        .orderBy('reviewDate',
                                            descending: false)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.docs.isNotEmpty) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              children: snapshot.data!.docs
                                                  .map((review) {
                                                final reviewData = review.data()
                                                    as Map<String, dynamic>;

                                                return ReviewPlace(
                                                  placeId: widget.placeid,
                                                  reviewId: review.id,
                                                  currentUserId: widget.userId,
                                                  ratingCount: reviewData[
                                                              'ratingCount'] ==
                                                          0
                                                      ? 3.5
                                                      : reviewData[
                                                          'ratingCount'],
                                                  text:
                                                      reviewData['reviewText'],
                                                  userId: reviewData[
                                                      'reviewUserId'],
                                                  date: formatDate(
                                                      reviewData['reviewDate']),
                                                );
                                              }).toList(),
                                            ),
                                          );
                                        } else {
                                          debugPrint('No reviews');
                                          return const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                FeatherIcons.frown,
                                                size: 30,
                                                color: Color(0xFFdbe8f1),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                'No Reviews!!!',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFbcdae8),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                'Be the first to write a review.',
                                                style: TextStyle(
                                                  color: Color(0xFFbcdae8),
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    resetStatusBarColor();
  }
}


