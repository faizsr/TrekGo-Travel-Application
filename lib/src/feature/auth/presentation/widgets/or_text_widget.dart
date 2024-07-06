import 'package:flutter/material.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';

class OrTextWidget extends StatelessWidget {
  const OrTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              thickness: 1,
              endIndent: 10,
              color: AppColors.black26,
            ),
          ),
          Text(
            'OR',
            style: TextStyle(color: AppColors.black38),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              indent: 10,
              color: AppColors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
