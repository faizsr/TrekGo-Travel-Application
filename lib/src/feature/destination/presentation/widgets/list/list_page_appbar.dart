import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';

class CustomAppbar extends StatelessWidget {
  final String? sortName;
  final String? title;
  final void Function()? onTap;

  const CustomAppbar({
    super.key,
    this.sortName,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: Container(
        height: 70,
        color: AppColors.skyBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(SolarIconsOutline.arrowLeft),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  children: [
                    Text(
                      'India',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                    Gap(width: 3),
                    Icon(
                      SolarIconsOutline.mapPoint,
                      size: 14,
                      color: Colors.black,
                    ),
                  ],
                ),
                const Gap(height: 2),
                Text(
                  title ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Gap(height: 30, width: 30),
            ),
          ],
        ),
      ),
    );
  }
}
