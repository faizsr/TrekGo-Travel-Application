import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? pageNavigator;
  const CustomBackButton({
    super.key,
    this.pageNavigator,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 10,
      child: IconButton(
        onPressed: pageNavigator,
        icon: Icon(
          MdiIcons.keyboardBackspace,
          size: 30,
        ),
      ),
    );
  }
}
