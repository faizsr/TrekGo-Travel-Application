import 'package:flutter/material.dart';

class ReviewPlace extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const ReviewPlace({
    super.key,
    required this.text,
    required this.user,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Text(text),
          Row(
            children: [
              Text(user),
              Text(time),
            ],
          ),
        ],
      ),
    );
  }
}
