import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_user_controller.dart';
import 'package:trekgo_project/src/feature/admin/presentation/views/add_place_page.dart';
import 'package:trekgo_project/src/feature/admin/presentation/views/places_list_page.dart';
import 'package:trekgo_project/src/feature/admin/presentation/views/users_list_page.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/count_card.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/manage_tile.dart';
import 'package:trekgo_project/src/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/user_login_page.dart';
import 'package:trekgo_project/src/feature/destination/presentation/controllers/destination_controller.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.skyBlue,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthController>(context, listen: false).logout();
              nextScreenRemoveUntil(context, const UserLoginPage());
            },
            icon: const Icon(SolarIconsOutline.logout),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: bgGradient),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          children: [
            Consumer2<DestinationController, ManageUserController>(
              builder: (context, v1, v2, child) {
                var totalDestinations =
                    v1.popular.length + v1.recommended.length;
                var totalUser = v2.users.length;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      CountCard(
                        count: '$totalUser',
                        title: 'Total Users',
                        icon: SolarIconsOutline.usersGroupRounded,
                      ),
                      const Gap(width: 20),
                      CountCard(
                        count: '$totalDestinations',
                        title: 'Total Places',
                        icon: SolarIconsOutline.map,
                      ),
                    ],
                  ),
                );
              },
            ),
            Text(
              'Manage',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.darkTeal,
              ),
            ),
            const Gap(height: 15),
            ManageTile(
              title: 'Add New Place',
              onTap: () {
                nextScreen(context, const AddPlacePage());
              },
            ),
            const Gap(height: 15),
            ManageTile(
              title: 'View All Places',
              onTap: () {
                nextScreen(context, const PlacesListPage());
              },
            ),
            const Gap(height: 15),
            ManageTile(
              title: 'View All Users',
              onTap: () {
                nextScreen(context, const UsersListPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
