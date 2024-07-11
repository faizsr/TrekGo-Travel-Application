import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class PlaceInfoActionSection extends StatelessWidget {
  const PlaceInfoActionSection({
    super.key,
    required this.destination,
  });

  final DestinationEntity destination;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width - 100,
                child: Text(
                  destination.name.replaceAll(RegExp(r'\s+'), ' '),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Gap(height: 4),
              CardRatingBar(
                itemSize: 20,
                isMainAlignCenter: true,
                ratingCount: destination.rating,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.darkTeal,
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            color: AppColors.white,
            onPressed: () {},
            icon: const Icon(SolarIconsOutline.bookmark, size: 22),
          ),
        ],
      ),
    );
  }
}
