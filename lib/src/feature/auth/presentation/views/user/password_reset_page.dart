import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/src/config/utils/alerts.dart';
import 'package:trekgo_project/src/config/utils/decorations.dart';
import 'package:trekgo_project/src/config/utils/gap.dart';
import 'package:trekgo_project/src/config/utils/validations.dart';
import 'package:trekgo_project/src/feature/auth/presentation/controllers/auth_controller.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/user/user_login_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/auth_appbar.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/auth_header.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/auth_layout_builder.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_filled_button.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_outlined_button.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_text_field.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/or_text_widget.dart';

class PasswordResetPage extends StatefulWidget {
  final String? resetText;
  final String? userEmail;
  final bool noBackToLogin;
  final bool adjustHeight;
  final String? backToLoginTxt;
  const PasswordResetPage({
    super.key,
    this.resetText,
    this.userEmail,
    this.noBackToLogin = false,
    this.adjustHeight = false,
    this.backToLoginTxt,
  });

  @override
  State<PasswordResetPage> createState() => PasswordResetPageState();
}

class PasswordResetPageState extends State<PasswordResetPage> {
  final emailController = TextEditingController();
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
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ===== Forgot password title =====
                    const AuthHeader(
                      title: 'Forgot Password?',
                      subTitle: 'Check mail to reset',
                    ),
                    const Gap(height: 30),

                    // ===== Email address field =====
                    CustomTextField(
                      controller: emailController,
                      title: 'Email Address',
                      onChanged: (val) {},
                      hintText: 'Enter a valid email address',
                      validator: validateEmail,
                    ),
                    const Gap(height: 20),

                    // ===== Confirm button =====

                    CustomFilledButton(
                      onPressed: onConfirmPressed,
                      text: 'Send Email',
                    ),
                    const OrTextWidget(),
                    CustomOutlinedButton(
                      text: 'Log In',
                      onPressed: onLoginPressed,
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

  Future<void> onConfirmPressed() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    if (formKey.currentState!.validate()) {
      await authController.forgotPassword(emailController.text);
    }

    String result = authController.result;
    if (result == 'success') {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Password Reset Email Sent',
          description:
              'Check your email for instructions to reset your password.',
          popBtnText: widget.backToLoginTxt ?? 'Back To Login',
          disableActionBtn: true,
          onTap: widget.backToLoginTxt == null
              ? () {
                  nextScreenReplace(context, const UserLoginPage());
                }
              : () => null,
        ),
      );
    } else if (result == 'user-not-found') {
      final snackbar = CustomAlerts.snackBar('User not found');
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
