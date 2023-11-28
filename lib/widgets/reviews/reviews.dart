import 'package:flutter/material.dart';

class ReviewPlace extends StatelessWidget {
  final String? text;
  final String? user;
  final String? time;
  const ReviewPlace({
    super.key,
    this.text,
    this.user,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text('data'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(user ?? '', maxLines: 2, overflow: TextOverflow.clip),
                Text(time ?? ''),
              ],
            ),
            Text(text ?? ''),
          ],
        ),
      ),
    );
  }
}
