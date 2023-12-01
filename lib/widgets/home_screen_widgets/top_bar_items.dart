import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/service/database_service.dart';

class TopBarItems extends StatefulWidget {
  final String? userId;
  final String? placeLocation;
  final void Function(int)? updateIndex;
  const TopBarItems({
    super.key,
    this.userId,
    this.placeLocation,
    this.updateIndex,
  });

  @override
  State<TopBarItems> createState() => _TopBarItemsState();
}

class _TopBarItemsState extends State<TopBarItems> {
  Stream<DocumentSnapshot>? userDataStream;

  @override
  void initState() {
    super.initState();
    userDataStream = DatabaseService().getUserDetails(widget.userId ?? '');
  }

  String? userProfilePic;

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
            widget.placeLocation == 'View All'
                ? const Text('India')
                : Text('${widget.placeLocation ?? 'Welcome to'}, India'),
          ],
        ),
        StreamBuilder(
          stream: userDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final userDataSnapshot =
                  snapshot.data!.data() as Map<String, dynamic>;

              userProfilePic = userDataSnapshot['profilePic'];
              return GestureDetector(
                onTap: () {
                  widget.updateIndex?.call(4);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.093,
                  height: MediaQuery.of(context).size.height * 0.044,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1285b9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FadeInImage(
                      placeholder: AssetImage(homeDefaultImage),
                      fit: BoxFit.cover,
                      image: userProfilePic == null
                          ? Image.asset(homeDefaultImage).image
                          : Image.network(userProfilePic ?? '').image,
                    ),
                  ),
                ),
              );
            }
            return Container(
              width: MediaQuery.of(context).size.width * 0.093,
              height: MediaQuery.of(context).size.height * 0.044,
              color: const Color(0xFF1285b9),
            );
          },
        ),
      ],
    );
  }
}
