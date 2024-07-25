import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_destination_controller.dart';

class AdminAppbar extends StatelessWidget {
  final String title;
  final bool enableAction;
  final void Function()? onPressed;

  const AdminAppbar({
    super.key,
    required this.title,
    this.enableAction = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      backgroundColor: AppColors.skyBlue,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(CupertinoIcons.arrow_left),
      ),
      actions: enableAction
          ? [
              Consumer<ManageDestinationController>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return Transform.scale(
                      alignment: Alignment.centerLeft,
                      scale: 0.5,
                      child: const CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    );
                  }
                  return IconButton(
                    onPressed: onPressed,
                    icon: const Icon(SolarIconsOutline.checkCircle),
                  );
                },
              )
            ]
          : [],
    );
  }
}
