import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/home/place_cards.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/feature/destination/presentation/controllers/destination_controller.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DestinationController>(context, listen: false).getPopular();
    });

    return Consumer<DestinationController>(
      builder: (context, value, child) {
        if (value.isLoading2) {
          return Container(
            margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: kBoxShadow2,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: AppColors.skyBlue,
                size: 35,
              ),
            ),
          );
        }
        if (value.popular.isNotEmpty) {
          return CarouselSlider.builder(
            itemCount: value.popular.length,
            itemBuilder: (context, index, realIndex) {
              return PlaceCardLg(destination: value.popular[index]);
            },
            options: CarouselOptions(
              // autoPlay: true,
              scrollPhysics: const BouncingScrollPhysics(),
              viewportFraction: 1.0,
              pauseAutoPlayInFiniteScroll: true,
              height: 350,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(seconds: 3),
            ),
          );
        }
        return Container(
          margin: const EdgeInsets.fromLTRB(20, 15, 20, 30),
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: kBoxShadow2,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(searchNoResult),
        );
      },
    );
  }
}
