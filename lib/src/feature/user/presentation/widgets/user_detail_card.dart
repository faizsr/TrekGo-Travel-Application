import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';

class UserDetailCard extends StatelessWidget {
  const UserDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.skyBlue,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(defaultImage),
                  ),
                ),
                height: 100,
                width: 100,
              ),
              const Gap(width: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Wick',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text('johnwick@gmail.com'),
                ],
              ),
              const Spacer(),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const Size(0, 0),
                backgroundColor: AppColors.darkTeal,
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                'EDIT',
                style: TextStyle(color: AppColors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
