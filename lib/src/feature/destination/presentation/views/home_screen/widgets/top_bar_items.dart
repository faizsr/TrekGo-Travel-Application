import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/changer/service/database_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';

class TopBarItems extends StatefulWidget {
  final String? userId;
  final String? placeLocation;
  final BuildContext scaffoldContext;
  final void Function(int)? updateIndex;

  const TopBarItems({
    super.key,
    this.userId,
    this.placeLocation,
    required this.scaffoldContext,
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
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Scaffold.of(widget.scaffoldContext).openDrawer();
            },
            child: Container(
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
                    indexChangeNotifier.value = 4;
                    // widget.updateIndex!.call(4);
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
                      child: userProfilePic != ''
                          ? CachedNetworkImage(
                              placeholder: (context, url) => Image.asset(
                                homeDefaultImage,
                                fit: BoxFit.cover,
                              ),
                              imageUrl: userProfilePic ?? '',
                              errorWidget: (context, url, error) => Image.asset(
                                homeDefaultImage,
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              homeDefaultImage,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              }
              return Container(
                width: MediaQuery.of(context).size.width * 0.093,
                height: MediaQuery.of(context).size.height * 0.044,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF1285b9),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
