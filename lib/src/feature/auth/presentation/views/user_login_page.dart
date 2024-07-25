import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/alerts.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/config/utils/validations.dart';
import 'package:trekgo_project/src/feature/admin/presentation/views/admin_dashboard_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/auth_header.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/auth_layout_builder.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_filled_button.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_outlined_button.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_text_button.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/or_text_widget.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/password_reset_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/user_signup_page.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthLayoutBuilder(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: kBoxShadow,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const AuthHeader(
                      title: 'Welcome Back,',
                      subTitle: 'Login to continue',
                    ),
                    const Gap(height: 30),

                    // ===== Email field =====
                    CustomTextField(
                      controller: emailController,
                      title: 'Email Address',
                      hintText: 'Enter your registered email...',
                      onChanged: (val) {},
                      validator: validateEmail,
                    ),
                    const Gap(height: 10),

                    CustomTextField(
                      controller: passwordController,
                      title: 'Password',
                      hintText: 'Enter your password...',
                      onChanged: (val) {},
                      validator: validatePasswordLogin,
                    ),
                    const Gap(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        onPressed: onForgotPressed,
                        text: 'Forgot Password?',
                      ),
                    ),

                    const Gap(height: 15),

                    CustomFilledButton(
                      onPressed: onLoginPressed,
                      text: 'Log In',
                      child: loginBtnChild(),
                    ),
                    const OrTextWidget(),
                    CustomOutlinedButton(
                      text: 'Sign Up',
                      onPressed: onSignUpPressed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Consumer<AuthController> loginBtnChild() {
    return Consumer<AuthController>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return Transform.scale(
            scale: 0.6,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.white,
            ),
          );
        }
        return Text(
          'Log In',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: AppColors.white,
          ),
        );
      },
    );
  }

  Future<void> onLoginPressed() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    if (formKey.currentState!.validate()) {
      final user = UserEntity(
        email: emailController.text,
        password: passwordController.text,
      );
      await authController.login(user);
    }

    String result = authController.result;
    if (result == 'success-user') {
      nextScreenRemoveUntil(context, const MainPage());
    } else if (result == 'success-admin') {
      nextScreenRemoveUntil(context, const AdminDashboardPage());
    } else if (result == 'user-not-found') {
      final snackbar = CustomAlerts.snackBar('User not found');
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (result == 'wrong-password') {
      final snackBar = CustomAlerts.snackBar('Incorrect password');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (result == 'account-disabled') {
      final snackbar = CustomAlerts.snackBar('Account Disabled by Admin');
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (result == 'too-many-requests') {
      final snackBar =
          CustomAlerts.snackBar('Too many requests. Please try again later.');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void onForgotPressed() {
    nextScreen(context, const PasswordResetPage());
  }

  void onSignUpPressed() {
    nextScreen(context, const UserSignUpPage());
  }
}
