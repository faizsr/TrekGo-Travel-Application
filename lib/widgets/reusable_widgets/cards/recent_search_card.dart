import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/main_pages/sub_pages/place_detail_screen.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/reusable_widgets/app_update_image_widget.dart';

class RecentSearchCard extends StatefulWidget {
  final String? cardImage;
  final String? cardTitle;
  final double? ratingCount;
  final String? placeId;
  final bool? isAdmin;
  final bool? isUser;
  final String? userId;
  const RecentSearchCard({
    super.key,
    this.cardImage,
    this.cardTitle,
    this.ratingCount,
    this.placeId,
    this.isAdmin,
    this.isUser,
    required this.userId,
  });

  @override
  State<RecentSearchCard> createState() => _RecentSearchCardState();
}

class _RecentSearchCardState extends State<RecentSearchCard> {
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
      onTap: () => nextScreen(
          context,
          PlaceDetailScreen(
            userId: widget.userId,
            isAdmin: widget.isAdmin,
            isUser: widget.isUser,
            placeid: widget.placeId,
          )),
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                offset: Offset(0, 4),
                color: Color(0x0D000000),
              )
            ]),
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(3.5),
              width: MediaQuery.of(context).size.width * 0.24,
              height: MediaQuery.of(context).size.height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                    lazyLoading,
                    fit: BoxFit.cover,
                  ),
                  imageUrl: widget.cardImage ?? '',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Image.asset(
                    lazyLoading,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Positioned(
              left: 115,
              top: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Text(
                      widget.cardTitle!.replaceAll(RegExp(r'\s+'), ' '),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CardRatingBar(
                    ratingCount: widget.ratingCount ?? 0,
                    itemSize: 18,
                    isRatingTextNeeded: true,
                  ),
                ],
              ),
            ),
            const Positioned(
              right: 15,
              top: 40,
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
