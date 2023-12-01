import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailController = TextEditingController();
  final AuthService authService = AuthService();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                    pageNavigator: () =>
                        nextScreenReplace(context, const UserLoginScreen()),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.all(25),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.8,
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
                            const TitleWidget(
                              mainText: 'Forgot Password?',
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
                              },
                              fieldHintText: 'Enter a valid email address...',
                              validator: (val) {
                                if ((RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(val!))) {
                                  return null;
                                } else {
                                  customSnackbar(
                                      context,
                                      'Please enter a valid email',
                                      150,
                                      55,
                                      55);
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
                              isOutlinedButton: true,
                              buttonWidth: 180,
                              buttonOnPressed: () async {
                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: emailController.text);
                                  return true;
                                } on FirebaseAuthException catch (e) {
                                  debugPrint(e.message);
                                  return false;
                                }
                                
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            //Help Text
                            InkWell(
                              onTap: () => nextScreenReplace(
                                  context, const UserLoginScreen()),
                              child: const HelpTextWidget(
                                firstText: "Back To ",
                                secondText: 'Login?',
                              ),
                            ),
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
    );
  }
}
