import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PlaceScreenAppbar extends StatelessWidget {
  final String? sortName;
  final String? title;
  final bool isLocationEnable;
  final bool showCheckIcon;
  final bool isLoading;
  final Function()? onTap;
  const PlaceScreenAppbar({
    super.key,
    this.sortName,
    this.title,
    this.isLocationEnable = true,
    this.showCheckIcon = false,
    this.isLoading = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Navigator.pop(context, 'refresh'),
        child: const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(
            Icons.keyboard_backspace_rounded,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Text(
              title ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            isLocationEnable
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MdiIcons.mapMarkerOutline,
                          size: 12,
                          color: Colors.black,
                        ),
                        sortName == 'View All'
                            ? const Text(
                                'India',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )
                            : Text(
                                '${sortName ?? 'Welcome to'}, India',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
      actions: [
        showCheckIcon
            ? Padding(
                padding: const EdgeInsets.only(top: 18, right: 10),
                child: GestureDetector(
                  onTap: onTap,
                  child: isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF1285b9),
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          MdiIcons.check,
                          color: Colors.black,
                        ),
                ),
              )
            : const SizedBox(),
      ],
      centerTitle: true,
      toolbarHeight: 100,
      elevation: 0,
      backgroundColor: const Color(0xFFe5e6f6),
    );
  }
}