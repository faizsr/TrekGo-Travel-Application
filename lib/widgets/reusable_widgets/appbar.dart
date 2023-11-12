import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  final String title;
  const AppbarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Icon(
          Icons.keyboard_backspace_rounded,
          color: Colors.black,
          size: 25,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
        ),
      ),
      centerTitle: true,
      toolbarHeight: 90,
      elevation: 0,
      backgroundColor: const Color(0xFFe5e6f6),
    );
  }
}
