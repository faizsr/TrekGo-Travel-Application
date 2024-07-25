import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';

class CurrencyCalculatorCard extends StatelessWidget {
  const CurrencyCalculatorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Currency Calculator',
                style: TextStyle(color: AppColors.black38),
              ),
              const Spacer(),
              Icon(
                CupertinoIcons.arrow_right,
                size: 16,
                color: AppColors.black38,
              )
            ],
          ),
          const Gap(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    countryCodeWidget('USD'),
                    currentValueWidget('\$1.00'),
                  ],
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.lightBlue,
                ),
                icon: Icon(
                  SolarIconsOutline.shuffle,
                  color: AppColors.black,
                ),
                onPressed: () {},
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    countryCodeWidget('INR'),
                    currentValueWidget('₹83.25'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Center currentValueWidget(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Container countryCodeWidget(String text) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
      decoration: BoxDecoration(
        color: AppColors.skyBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text),
    );
  }
}
