import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class AppbarTitleItems extends StatelessWidget {
  final String? appbarTitleText;
  final double? titleSize;
  final double? iconSize;
  final bool isbold;
  final bool isTrailingNeeded;

  const AppbarTitleItems({
    super.key,
    this.appbarTitleText,
    this.titleSize,
    this.iconSize,
    this.isbold = false,
    this.isTrailingNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.keyboard_backspace_rounded,
                size: iconSize,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Center(
            child: Text(
              appbarTitleText!,
              style: TextStyle(
                fontWeight: isbold ? FontWeight.w600 : FontWeight.bold,
                fontSize: titleSize,
                color: Colors.black,
              ),
            ),
          ),
        ),
        isTrailingNeeded
            ? Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      FeatherIcons.check,
                      size: iconSize,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
