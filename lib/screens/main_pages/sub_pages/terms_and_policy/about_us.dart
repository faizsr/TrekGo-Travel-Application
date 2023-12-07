import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/widgets/home_screen_widgets/pop_and_recd_appbar.dart';
import 'package:trekmate_project/widgets/reusable_widgets/section_titles.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: const PlaceScreenAppbar(
          title: 'About Us',
          isLocationEnable: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 15, right: 10, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitles(
                titleText: 'Welcome to TrekGo,',
                noPadding: 0,
                textSize: 24,
              ),
              Text(
                aboutUs!,
                softWrap: true,
              ),
              const SectionTitles(
                titleText: 'Our Vision',
                noPadding: 0,
                textSize: 16,
              ),
              Text(
                ourVision ?? '',
                softWrap: true,
              ),
              const SectionTitles(
                titleText: 'Our Commitment',
                noPadding: 0,
                textSize: 16,
              ),
              Text(
                ourCommitment ?? '',
                softWrap: true,
              ),
              const SectionTitles(
                titleText: 'Join Us on the Journey',
                noPadding: 0,
                textSize: 16,
              ),
              Text(
                joinUs ?? '',
                softWrap: true,
              ),
              // const SectionTitles(
              //   titleText: 'Security',
              //   noPadding: 0,
              //   textSize: 16,
              // ),
              // Text(
              //   security ?? '',
              //   softWrap: true,
              // ),
              // const SectionTitles(
              //   titleText: 'Links to Other Sites',
              //   noPadding: 0,
              //   textSize: 16,
              // ),
              // Text(
              //   linksToOtherSites ?? '',
              //   softWrap: true,
              // ),
              // const SectionTitles(
              //   titleText: "Children's Privacy",
              //   noPadding: 0,
              //   textSize: 16,
              // ),
              // Text(
              //   childrensPrivacy ?? '',
              //   softWrap: true,
              // ),
              // const SectionTitles(
              //   titleText: "Changes to This Privacy Policy",
              //   noPadding: 0,
              //   textSize: 16,
              // ),
              // Text(
              //   changesToPrivayPolicy ?? '',
              //   softWrap: true,
              // ),
              // const SectionTitles(
              //   titleText: "Contacy Us",
              //   noPadding: 0,
              //   textSize: 16,
              // ),
              // Text(
              //   contactUs ?? '',
              //   softWrap: true,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
