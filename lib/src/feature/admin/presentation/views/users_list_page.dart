import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_user_controller.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/admin_appbar.dart';
import 'package:trekgo_project/src/feature/admin/presentation/widgets/admin_user_card.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ManageUserController>(context, listen: false).fetchAllUser();
    });

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AdminAppbar(title: 'All Users'),
      ),
      body: Consumer<ManageUserController>(
        builder: (context, value, child) {
          List<UserEntity> users = value.users;
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            separatorBuilder: (context, index) => const Gap(height: 15),
            itemCount: users.length,
            itemBuilder: (context, index) {
              UserEntity user = users[index];
              return AdminUserCard(user: user);
            },
          );
        },
      ),
    );
  }
}
