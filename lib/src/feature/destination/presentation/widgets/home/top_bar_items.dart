import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/user/presentation/controllers/user_controller.dart';

class TopBarItems extends StatefulWidget {
  final BuildContext scaffoldContext;

  const TopBarItems({
    super.key,
    required this.scaffoldContext,
  });

  @override
  State<TopBarItems> createState() => _TopBarItemsState();
}

class _TopBarItemsState extends State<TopBarItems> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        cornerButton(
          onPressed: () => Scaffold.of(widget.scaffoldContext).openDrawer(),
          icon: SolarIconsOutline.list_1,
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppColors.black),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(MdiIcons.mapMarkerOutline, size: 15),
              const Gap(width: 4),
              const Text('Welcome to India'),
            ],
          ),
        ),
        StreamBuilder(
          stream: userController.getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data as UserEntity;
              return cornerButton(
                onPressed: () => indexChangeNotifier.value = 4,
                child: CachedNetworkImage(
                  placeholder: (context, url) => const Icon(
                    SolarIconsBold.user,
                    color: Colors.white,
                    size: 22,
                  ),
                  imageUrl: user.profilePhoto,
                  errorWidget: (context, url, error) => const Icon(
                    SolarIconsBold.user,
                    color: Colors.white,
                    size: 22,
                  ),
                  fit: BoxFit.cover,
                ),
              );
            }
            return cornerButton(
              onPressed: () => indexChangeNotifier.value = 4,
              icon: SolarIconsOutline.user,
            );
          },
        ),
      ],
    );
  }

  CupertinoButton cornerButton({
    required void Function()? onPressed,
    IconData? icon,
    Widget? child,
  }) {
    return CupertinoButton(
      color: AppColors.darkTeal,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(10),
      pressedOpacity: 0.8,
      minSize: 35,
      onPressed: onPressed,
      child: child ?? Icon(icon, size: 24),
    );
  }
}
