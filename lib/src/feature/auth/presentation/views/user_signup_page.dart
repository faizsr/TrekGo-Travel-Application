import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/src/config/constants/app_colors.dart';
import 'package:trekgo_project/src/config/utils/alerts.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/config/utils/validations.dart';
import 'package:trekgo_project/src/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/user_login_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/auth_appbar.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/auth_header.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/auth_layout_builder.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_filled_button.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_outlined_button.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/or_text_widget.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

class UserSignUpPage extends StatefulWidget {
  const UserSignUpPage({super.key});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AuthAppbar(),
      ),
      body: AuthLayoutBuilder(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                boxShadow: kBoxShadow,
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeader(
                      title: 'Setting Up,',
                      subTitle: 'Create your account',
                    ),
                    const Gap(height: 30),

                    // ===== Full name field =====
                    CustomTextField(
                      controller: nameController,
                      title: 'Full Name',
                      hintText: 'Enter your full name...',
                      onChanged: (val) {},
                      validator: validateName,
                    ),
                    const Gap(height: 10),

                    // ===== Email field =====
                    CustomTextField(
                      controller: emailController,
                      title: 'Email Address',
                      hintText: 'Enter your email address...',
                      onChanged: (val) {},
                      validator: validateEmail,
                    ),
                    const Gap(height: 10),

                    // ===== Create password field =====
                    CustomTextField(
                      controller: passwordController,
                      title: 'Create Password',
                      hintText: 'Enter a strong password...',
                      onChanged: (val) {},
                      validator: validatePassword,
                    ),
                    const Gap(height: 20),

                    // ===== Sign Up button =====
                    CustomFilledButton(
                      text: 'Sign Up',
                      onPressed: onSignUpPressed,
                      child: signupBtnChild(),
                    ),
                    const OrTextWidget(),

                    // ===== Help text (login in) =====
                    CustomOutlinedButton(
                      onPressed: onLoginPressed,
                      text: 'Log In',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Consumer<AuthController> signupBtnChild() {
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
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: AppColors.white,
          ),
        );
      },
    );
  }

  void onSignUpPressed() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    if (formKey.currentState!.validate()) {
      final user = UserEntity(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
      await authController.signUp(user);
    }

    String result = authController.result;
    if (result == 'success') {
      nextScreenRemoveUntil(context, const MainPage());
      final snackbar = CustomAlerts.snackBar('Account Created Successfully');
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (result == 'email-already-in-use') {
      final snackbar = CustomAlerts.snackBar('Email already in use');
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else if (result == 'too-many-requests') {
      final snackBar =
          CustomAlerts.snackBar('Too many requests. Please try again later.');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void onLoginPressed() {
    nextScreenRemoveUntil(context, const UserLoginPage());
  }
}
