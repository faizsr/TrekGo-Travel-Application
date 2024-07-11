import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/user/user_login_page.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/user/presentation/controllers/user_controller.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/settings_screen/settings_screen.dart';
import 'package:trekgo_project/changer/screens/main_pages/sub_pages/wishlist_screen.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomDrawer({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    return Drawer(
      shape: const RoundedRectangleBorder(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        decoration: BoxDecoration(gradient: bgGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            StreamBuilder<UserEntity>(
              stream: userController.getUserDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data as UserEntity;
                  return InkWell(
                    onTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                      indexChangeNotifier.value = 4;
                      debugPrint('Profile Pressed');
                    },
                    child: headerWidget(user: user),
                  );
                }
                return Container();
              },
            ),
            const Gap(height: 50),
            Divider(height: 1, thickness: 1, color: AppColors.black12),
            const Gap(height: 50),
            DrawerItem(
              name: 'Home',
              icon: SolarIconsOutline.homeAngle_2,
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
                indexChangeNotifier.value = 0;
                debugPrint('Home Pressed');
              },
            ),
            DrawerItem(
              name: 'Explore',
              icon: SolarIconsOutline.roundedMagnifier,
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
                indexChangeNotifier.value = 1;
                debugPrint('Explore Pressed');
              },
            ),
            DrawerItem(
              name: 'Saved',
              icon: SolarIconsOutline.bookmark,
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
                indexChangeNotifier.value = 3;
                debugPrint('Wishlist Pressed');
              },
            ),
            DrawerItem(
              name: 'Wishlists',
              icon: SolarIconsOutline.heart,
              onPressed: () {
                nextScreen(
                  context,
                  const WishlistScreen(),
                );
              },
            ),
            DrawerItem(
              name: 'Settings',
              icon: SolarIconsOutline.settings,
              onPressed: () {
                nextScreen(
                  context,
                  const SettingsScreen(),
                );
              },
            ),
            DrawerItem(
              name: 'Logout',
              icon: SolarIconsOutline.logout,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      actionBtnTxt: 'Yes',
                      title: 'Confirm Logout',
                      description: 'Are you sure?',
                      onTap: () {
                        nextScreenRemoveUntil(context, const UserLoginPage());
                      },
                    );
                  },
                );
              },
            ),
            const Gap(height: 50),
            Divider(height: 1, thickness: 1, color: AppColors.black12),
            const Spacer(),
            Center(
              child: Image.asset(appName),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWidget({required UserEntity user}) {
    String image = defaultImage;
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: AppColors.darkTeal,
            ),
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: user.profilePhoto != ''
                ? CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                      lazyLoading,
                      fit: BoxFit.cover,
                    ),
                    imageUrl: user.profilePhoto,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Image.asset(
                      lazyLoading,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image(image: AssetImage(image)),
          ),
        ),
        const Gap(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name.capitalise(),
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Gap(height: 2),
              Text(
                user.email,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function() onPressed;
  const DrawerItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: AppColors.darkTeal,
            ),
            const Gap(width: 30),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
