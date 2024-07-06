import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthAppbar extends StatelessWidget {
  const AuthAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: IconButton(
        // style: IconButton.styleFrom(
        //   backgroundColor: AppColors.white
        // ),
        padding: const EdgeInsets.all(10),
        onPressed: () => Navigator.pop(context),
        icon: const Icon(CupertinoIcons.arrow_left),
      ),
    );
  }
}
