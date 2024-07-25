import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/src/feature/destination/presentation/views/place_detail_page.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class PlaceCardLg extends StatelessWidget {
  final DestinationEntity destination;
  final bool isDetail;

  const PlaceCardLg({
    super.key,
    required this.destination,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    final double pb = isDetail ? 5 : 30;
    log('$isDetail $pb');
    return GestureDetector(
      onTap: () {
        nextScreen(context, PlaceDetailPage(destination: destination));
      },
      child: Container(
        height: 305,
        margin: EdgeInsets.fromLTRB(20, 15, 20, pb),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: kBoxShadow2,
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name.replaceAll(RegExp(r'\s+'), ' '),
                      style: TextStyle(
                        color: AppColors.darkTeal,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(height: 2),
                    CardRatingBar(
                      ratingCount: destination.rating,
                      itemSize: 20,
                      isRatingTextNeeded: true,
                    ),
                    const Gap(height: 4),
                    const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Hero(
              tag: destination.image,
              child: SizedBox(
                height: 220,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      lazyLoading,
                      fit: BoxFit.cover,
                    ),
                    imageUrl: destination.image,
                    errorWidget: (context, url, error) =>
                        Image.asset(lazyLoading, fit: BoxFit.cover),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 70,
              child: saveIconBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget saveIconBtn() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: kBoxShadow,
        ),
        child: Icon(
          SolarIconsOutline.bookmark,
          color: AppColors.darkTeal,
          size: 22,
        ),
      ),
    );
  }
}

class PlaceCardSm extends StatelessWidget {
  final DestinationEntity destination;

  const PlaceCardSm({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => nextScreen(
        context,
        PlaceDetailPage(destination: destination),
      ),
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: kBoxShadow2,
        ),
        width: MediaQuery.of(context).size.width / 2.3,
        child: Column(
          children: [
            Hero(
              tag: destination.image,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.3,
                height: MediaQuery.of(context).size.height / 5.1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      lazyLoading,
                      fit: BoxFit.cover,
                    ),
                    imageUrl: destination.image,
                    errorWidget: (context, url, error) =>
                        Image.asset(lazyLoading, fit: BoxFit.cover),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      destination.name.replaceAll(RegExp(r'\s+'), ' '),
                      style: TextStyle(
                        color: AppColors.darkTeal,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const Gap(height: 2),
                  CardRatingBar(
                    ratingCount: destination.rating,
                    itemSize: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
