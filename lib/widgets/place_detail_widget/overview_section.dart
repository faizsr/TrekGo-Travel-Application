import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OverViewSection extends StatelessWidget {
  final String? description;
  final String? location;
  final String? mapLink;
  const OverViewSection(
      {super.key, this.description, this.location, this.mapLink});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              description ?? '',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          const Divider(
            height: 30,
            thickness: 1,
            color: Color(0x0D000000),
          ),
          InkWell(
            onTap: () => openGoogleMap(mapLink: mapLink),
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 75),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 30,
                    color: Color(0xFF1285b9),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      location ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
