import 'package:flutter/material.dart';
import 'package:trekgo_project/src/feature/destination/presentation/views/place_list_page.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/home/custom_carousel_slider.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/home/custom_horiz_slider.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/list/section_separator_widget.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/home/top_bar_items.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/home/greetings_widget.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/home/filter_button_list.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: bgGradient),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  TopBarItems(scaffoldContext: context),
                  const Gap(height: 20),
                  const GreetingsWidget()
                ],
              ),
            ),
            FilterButtonList(onSortNameChanged: (newSortName) {}),
            Column(
              children: [
                // ===== Popular places section =====
                MainSubtitles(
                  subtitleText: 'Popular',
                  onTap: () => nextScreen(
                    context,
                    const PlaceListPage(title: 'Popular'),
                  ),
                ),
                const CustomCarouselSlider(),

                // ===== Recommended places section =====
                MainSubtitles(
                  subtitleText: 'Recommended',
                  onTap: () => nextScreen(
                    context,
                    const PlaceListPage(title: 'Recommended'),
                  ),
                ),
                const CustomHorizSlider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
