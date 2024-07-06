import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/changer/service/database_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';

class ReviewPlace extends StatefulWidget {
  final String? text;
  final String? placeId;
  final String? reviewId;
  final String? userId;
  final String? currentUserId;
  final String? date;
  final num? ratingCount;
  const ReviewPlace({
    super.key,
    this.text,
    this.placeId,
    this.reviewId,
    this.userId,
    this.currentUserId,
    this.date,
    this.ratingCount,
  });

  @override
  State<ReviewPlace> createState() => _ReviewPlaceState();
}

class _ReviewPlaceState extends State<ReviewPlace> {
  Stream<DocumentSnapshot>? userDataStream;

  @override
  void initState() {
    super.initState();
    userDataStream = DatabaseService().getUserDetails(widget.userId ?? '');
  }

  String? userName;
  String? userProfile;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userDataSnapshot =
              snapshot.data!.data() as Map<String, dynamic>;
          userName = userDataSnapshot['fullname'];
          userProfile = userDataSnapshot['profilePic'];
          return Container(
            margin: const EdgeInsets.only(
              bottom: 10,
              right: 10,
              left: 10,
            ),
            child: Slidable(
              closeOnScroll: true,
              enabled: widget.currentUserId == widget.userId ? true : false,
              endActionPane: ActionPane(
                extentRatio: 0.24,
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    autoClose: true,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (_) {
                      deleteReview(
                        widget.reviewId ?? '',
                        widget.placeId ?? '',
                      );
                    },
                    icon: MdiIcons.delete,
                    backgroundColor: const Color(0xFFc0f8fe),
                  )
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFf9fafc),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7, left: 3),
                      width: MediaQuery.of(context).size.width * 0.10,
                      height: MediaQuery.of(context).size.height * 0.045,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: AssetImage(defaultImage),
                          fit: BoxFit.cover,
                          image: userProfile == ''
                              ? Image.asset(defaultImage).image
                              : CachedNetworkImageProvider(userProfile ?? ''),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(10),
                      color: const Color(0xFFf9fafc),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  CardRatingBar(
                                    itemSize: 20,
                                    ratingCount: widget.ratingCount?.toDouble(),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    widget.date ?? '',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.text ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Future<void> deleteReview(String reviewId, String placeId) async {
    await FirebaseFirestore.instance
        .collection('destination')
        .doc(placeId)
        .collection('reviews')
        .doc(reviewId)
        .delete();
    debugPrint('Review deleted successfully');
  }
}
