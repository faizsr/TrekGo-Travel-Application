import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/user/presentation/controllers/user_controller.dart';

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
  String? userProfilePic;

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

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
          StreamBuilder<UserEntity>(
            stream: userController.getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data as UserEntity;
                userProfilePic = user.profilePhoto;
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
