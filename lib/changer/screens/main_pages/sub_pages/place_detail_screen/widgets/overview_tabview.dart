import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class OverViewSection extends StatelessWidget {
  final DestinationEntity destination;
  const OverViewSection({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTeal,
            ),
          ),
          const Gap(height: 5),
          ReadMoreText(
            '${destination.description}  ',
            trimMode: TrimMode.Line,
            trimLines: 4,
            colorClickableText: Colors.pink,
            trimCollapsedText: ' more',
            trimExpandedText: 'less',
            moreStyle: TextStyle(color: AppColors.black38),
            lessStyle: TextStyle(color: AppColors.black38),
          ),
        ],
      ),
    );
  }

  openGoogleMap({String? mapLink}) {
    String link = mapLink ?? '';
    Uri uri = Uri.parse(link);
    launchgoogleMap(uri);
  }

  launchgoogleMap(Uri googleMapsUrl) async {
    if (await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication)) {
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
