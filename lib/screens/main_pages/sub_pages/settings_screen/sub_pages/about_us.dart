import 'package:flutter/material.dart';
import 'package:trekgo_project/assets.dart';
import 'package:trekgo_project/widgets/reusable_widgets/reusable_widgets.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: const CustomAppbar(
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
            ],
          ),
        ),
      ),
    );
  }
}
