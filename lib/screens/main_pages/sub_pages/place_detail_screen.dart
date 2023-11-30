import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/screens/admin/widget/add_place_rating_widget.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/widgets.dart';
import 'package:trekmate_project/widgets/place_detail_widget/overview_buttons.dart';
import 'package:trekmate_project/widgets/place_detail_widget/overview_section.dart';
import 'package:trekmate_project/widgets/place_detail_widget/review_section_text_field.dart';
import 'package:trekmate_project/widgets/place_detail_widget/reviews.dart';
import 'package:trekmate_project/widgets/reusable_widgets/card_rating_bar.dart';

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
      'ratingCount': addedRating ?? 0,
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
          MediaQuery.of(context).size.height * 0.11,
        ),
        child: Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            left: 45,
            right: 45,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7.0,
                sigmaY: 4.0,
              ),
              child: Stack(
                children: [
                  const Align(
                    child: Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.keyboard_backspace_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
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

                String image = destinationSnapshot['place_image'];
                String category = destinationSnapshot['place_category'];
                String state = destinationSnapshot['place_state'];
                String title = destinationSnapshot['place_name'];
                String description = destinationSnapshot['place_description'];
                String location = destinationSnapshot['place_location'];
                double rating = destinationSnapshot['place_rating'];
                String mapLink = destinationSnapshot['place_map'];

                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ============ Place Image ============
                      Container(
                        margin: const EdgeInsets.only(
                          top: 25,
                          bottom: 20,
                          left: 25,
                          right: 25,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                destinationSnapshot['place_image'] ?? ''),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 15,
                              spreadRadius: 2,
                              color: Color(0x0D000000),
                            ),
                          ],
                        ),
                      ),

                      // ============ Place Title ============
                      Text(
                        destinationSnapshot['place_name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      CardRatingBar(
                        itemSize: 20,
                        isMainAlignCenter: true,
                        ratingCount: destinationSnapshot['place_rating'],
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
                                    description: description,
                                    location: location,
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
                                    initialRatingCount: addedRating ?? 0,
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
                                        setState(() {
                                          addedRating = ratingCount;
                                          debugPrint(
                                              'Rating after posting: $addedRating');
                                          FirebaseFirestore.instance
                                              .collection('destination')
                                              .doc(widget.placeid)
                                              .collection('reviews')
                                              .doc()
                                              .set({
                                            'user_rating_count': addedRating
                                          });
                                        });
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
                                      if (reviewController.text.isNotEmpty) {
                                        addComment(
                                          reviewText: reviewController.text,
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
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return SingleChildScrollView(
                                        child: Column(
                                          children:
                                              snapshot.data!.docs.map((review) {
                                            final reviewData = review.data()
                                                as Map<String, dynamic>;
                                            return ReviewPlace(
                                              placeId: widget.placeid,
                                              reviewId: review.id,
                                              currentUserId: widget.userId,
                                              ratingCount:
                                                  reviewData['ratingCount'],
                                              text: reviewData['reviewText'],
                                              userId:
                                                  reviewData['reviewUserId'],
                                              time: formatDate(
                                                  reviewData['reviewDate']),
                                            );
                                          }).toList(),
                                        ),
                                      );
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

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();

  String formattedDate = '$day/$month/$year';

  return formattedDate;
}
