// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekgo_project/assets.dart';
import 'package:trekgo_project/screens/user/user_login_screen.dart';
import 'package:trekgo_project/service/auth_service.dart';
import 'package:trekgo_project/screens/user/widget/widgets.dart';
import 'package:trekgo_project/widgets/reusable_widgets/alerts_and_navigates.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? resetText;
  final String? userEmail;
  final bool noBackToLogin;
  final bool adjustHeight;
  final String? backToLoginTxt;
  const ForgotPasswordScreen({
    super.key,
    this.resetText,
    this.userEmail,
    this.noBackToLogin = false,
    this.adjustHeight = false,
    this.backToLoginTxt,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  final AuthService authService = AuthService();

  final formkey = GlobalKey<FormState>();
  bool isButtonEnable = false;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.userEmail ?? '';
  }

  @override
  Widget build(BuildContext context) {
    String email;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.973,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  // ===== Background image =====
                  color: Color(0xFFE5E6F6),

                  // image: DecorationImage(
                  //   image: AssetImage(backgroundImageWithLogo),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CustomBackButton(
                          pageNavigator: () => Navigator.of(context).pop()),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.all(25),
                          width: MediaQuery.of(context).size.width,
                          height: widget.adjustHeight == false
                              ? MediaQuery.of(context).size.height / 2.8
                              : MediaQuery.of(context).size.height * 0.33,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ===== Forgot password title =====
                                TitleWidget(
                                  mainText:
                                      widget.resetText ?? 'Forgot Password?',
                                  mainTextSize: 24,
                                  isMainTextWeight: true,
                                ),
                                const SizedBox(
                                  height: 35,
                                ),

                                // ===== Email address field =====
                                TextFieldWidget(
                                  controller: emailController,
                                  fieldTitle: 'Email Address',
                                  onChanged: (val) {
                                    email = val;
                                    debugPrint(email);
                                    setState(() {
                                      isButtonEnable =
                                          emailController.text.isNotEmpty;
                                    });
                                  },
                                  fieldHintText:
                                      'Enter a valid email address...',
                                  validator: (val) {
                                    if ((RegExp(
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(val!))) {
                                      return null;
                                    } else {
                                      customSnackbar(
                                          context,
                                          'Please enter a valid email',
                                          20,
                                          20,
                                          20);
                                      return;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 40,
                                ),

                                // ===== Confirm button =====
                                ButtonsWidget(
                                  buttonText: 'CONFIRM',
                                  // isOutlinedButton: true,
                                  buttonWidth: 180,
                                  buttonOnPressed: isButtonEnable
                                      ? () async {
                                          if (formkey.currentState!
                                              .validate()) {
                                            try {
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                      email:
                                                          emailController.text);
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    CustomAlertDialog(
                                                  title:
                                                      'Password Reset Email Sent',
                                                  description:
                                                      'Check your email for instructions to reset your password.',
                                                  popBtnText:
                                                      widget.backToLoginTxt ??
                                                          'Back To Login',
                                                  disableActionBtn: true,
                                                  onTap:
                                                      widget.backToLoginTxt ==
                                                              null
                                                          ? () {
                                                              nextScreenReplace(
                                                                  context,
                                                                  const UserLoginScreen());
                                                            }
                                                          : () => null,
                                                ),
                                              );

                                              return true;
                                            } on FirebaseAuthException catch (e) {
                                              debugPrint(e.message);
                                              return false;
                                            }
                                          }
                                        }
                                      : null,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                //Help Text
                                widget.noBackToLogin == false
                                    ? InkWell(
                                        onTap: () => nextScreenReplace(
                                            context, const UserLoginScreen()),
                                        child: const HelpTextWidget(
                                          firstText: "Back To ",
                                          secondText: 'Login?',
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 40,
                child: Image.asset(appName),
              )
            ],
          ),
        ),
      ),
    );
  }
}
