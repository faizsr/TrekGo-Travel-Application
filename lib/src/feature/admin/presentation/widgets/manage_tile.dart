import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class ManageTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const ManageTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15),
            ),
            const Icon(CupertinoIcons.arrow_right, size: 22)
          ],
        ),
      ),
    );
  }
}
