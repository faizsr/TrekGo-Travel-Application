import 'package:flutter/material.dart';

class UserProfileListtile extends StatelessWidget {
  final String titleText;
  final Function()? onTap;
  const UserProfileListtile({
    super.key,
    required this.titleText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 5,
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      title: Text(
        titleText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
        color: Colors.black,
      ),
    );
  }
}
