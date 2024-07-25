import 'package:flutter/material.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/place_detail_appbar.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/overview_section.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_filled_button.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/place_image_section.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/place_info_action_section.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/detail/review_section.dart';

class PlaceDetailPage extends StatelessWidget {
  final DestinationEntity destination;

  const PlaceDetailPage({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: PlaceDetailAppbar(),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: bgGradient),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlaceImageSection(destination: destination),
              PlaceInfoActionSection(destination: destination),
              const Gap(height: 10),
              Divider(thickness: 1, color: Colors.grey.shade300),
              OverViewSection(destination: destination),
              const ReviewSection(),
              const Gap(height: 70),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
        child: CustomFilledButton(
          onPressed: () {},
          text: 'Get Direction',
          isBlurred: true,
        ),
      ),
    );
  }
}
