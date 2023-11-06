import 'package:flutter/material.dart';

class UserProfileListtile extends StatelessWidget {
  final String titleText;
  final Function()? onTapIcon;
  const UserProfileListtile({
    super.key,
    required this.titleText,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        titleText,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: GestureDetector(
        onTap: onTapIcon,
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
