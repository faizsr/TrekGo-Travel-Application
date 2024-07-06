import 'package:flutter/material.dart';

class ListtileItem extends StatelessWidget {
  final String? listtileText;
  final void Function()? onTap;
  const ListtileItem({
    super.key,
    this.listtileText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                listtileText!,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
