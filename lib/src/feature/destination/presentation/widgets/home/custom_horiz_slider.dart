import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:trekgo_project/src/feature/destination/presentation/widgets/home/place_cards.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/feature/destination/presentation/controllers/destination_controller.dart';

class CustomHorizSlider extends StatelessWidget {
  const CustomHorizSlider({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DestinationController>(context, listen: false)
          .getRecommended();
    });
    // ===== Recommended places carousel slider =====
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 15, bottom: 20),
        child: Consumer<DestinationController>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Row(
                children: List.generate(
                  6,
                  (index) => Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    height: MediaQuery.of(context).size.height / 4.5,
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: kBoxShadow2,
                    ),
                    child: Center(
                      child: LoadingAnimationWidget.threeArchedCircle(
                        color: AppColors.skyBlue,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              );
            }
            if (value.recommended.isNotEmpty) {
              return Row(
                children: value.recommended.map<Widget>((destination) {
                  return PlaceCardSm(destination: destination);
                }).toList(),
              );
            }
            return Row(
              children: List.generate(
                6,
                (index) => Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.height / 4.5,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: kBoxShadow2,
                  ),
                  child: Transform.scale(
                    scale: 0.5,
                    child: Image.asset(searchNoResult),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
