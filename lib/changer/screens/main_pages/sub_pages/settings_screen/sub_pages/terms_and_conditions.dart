import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/reusable_widgets.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(const Color(0xFFe5e6f6));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.1,
        child: const CustomAppbar(
          title: 'Terms & Conditions',
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
                titleText: 'TrekGo',
                noPadding: 0,
                textSize: 18,
              ),
              Text(
                termsAndConditions!,
                softWrap: true,
              ),
              const SectionTitles(
                titleText: 'Changes to This Terms and Conditions',
                noPadding: 0,
                textSize: 16,
              ),
              Text(
                changesToTermsConditions ?? '',
                softWrap: true,
              ),
              const SectionTitles(
                titleText: 'Contact Us',
                noPadding: 0,
                textSize: 16,
              ),
              Text(
                contactUs ?? '',
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
