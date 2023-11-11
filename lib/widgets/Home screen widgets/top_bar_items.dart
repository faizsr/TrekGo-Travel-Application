import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/assets.dart';

class TopBarItems extends StatelessWidget {
  final String? placeLocation;
  const TopBarItems({
    super.key,
    this.placeLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.093,
          height: MediaQuery.of(context).size.height * 0.044,
          decoration: BoxDecoration(
            color: const Color(0xFF1285b9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            MdiIcons.text,
            color: Colors.white,
            size: 30,
          ),
        ),
        Row(
          children: [
            Icon(
              MdiIcons.mapMarkerOutline,
              size: 13,
              
            ),
            placeLocation == 'View All'
                ? const Text('India')
                : Text('${placeLocation ?? 'Welcome to'}, India'),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.093,
          height: MediaQuery.of(context).size.height * 0.044,
          decoration: BoxDecoration(
            color: const Color(0xFF1285b9),
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(userProfile),
            ),
          ),
        ),
      ],
    );
  }
}
