import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/admin/presentation/controllers/manage_user_controller.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_outlined_button.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class AdminUserCard extends StatelessWidget {
  const AdminUserCard({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTeal,
                  ),
                ),
                const Gap(height: 5),
                listItem(
                  text1: 'ID: ',
                  text2: user.id,
                ),
                const Gap(height: 3),
                listItem(
                  text1: 'Email: ',
                  text2: user.email,
                ),
                const Gap(height: 3),
                listItem(
                  text1: 'Created Date ',
                  text2: user.createdDate!,
                ),
              ],
            ),
          ),
          const Gap(height: 15),
          CustomOutlinedButton(
            height: 45,
            onPressed: () => onBtnPressed(context),
            text: user.block ? 'Unblock' : 'Block',
          )
        ],
      ),
    );
  }

  void onBtnPressed(BuildContext context) {
    var manageUserCtr =
        Provider.of<ManageUserController>(context, listen: false);
    if (user.block) {
      manageUserCtr.unblockUser(user.id);
    } else {
      manageUserCtr.blockUser(user.id);
    }
  }

  Row listItem({required String text1, required String text2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(text2),
      ],
    );
  }
}
