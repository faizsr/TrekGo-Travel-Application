import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/user_login_page.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/src/feature/user/presentation/widgets/currency_calculator_card.dart';
import 'package:trekgo_project/src/feature/user/presentation/widgets/icon_text_card.dart';
import 'package:trekgo_project/src/feature/user/presentation/widgets/profile_listtile.dart';
import 'package:trekgo_project/src/feature/user/presentation/widgets/user_detail_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(gradient: bgGradient),
        child: ListView(
          shrinkWrap: true,
          children: [
            const UserDetailCard(),
            const CurrencyCalculatorCard(),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTextCard(
                    iconImg: 'assets/images/bucketlist_logo.png',
                    title: 'Bucket Lists',
                  ),
                  Gap(width: 20),
                  IconTextCard(
                    iconImg: 'assets/images/globe_logo.png',
                    title: 'My Trips',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  UserProfileListtile(
                    titleText: 'Activity',
                    onTap: () {},
                  ),
                  UserProfileListtile(
                    titleText: 'Saved',
                    onTap: () => indexChangeNotifier.value = 2,
                  ),
                  UserProfileListtile(
                    titleText: 'Settings',
                    onTap: () {},
                  ),
                  UserProfileListtile(
                    titleText: 'Logout',
                    onTap: () => onLogoutPressed(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Divider kDivider1() {
    return Divider(
      thickness: 1,
      indent: 15,
      endIndent: 15,
      color: Colors.grey.shade200,
    );
  }

  onLogoutPressed(context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          actionBtnTxt: 'Yes',
          title: 'Confirm Logout',
          description: 'Are you sure?',
          onTap: () {
            Provider.of<AuthController>(context, listen: false).logout();
            nextScreenRemoveUntil(context, const UserLoginPage());
          },
        );
      },
    );
  }
}
