import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/User/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/button.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/help_text.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/title.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/back_button.dart';

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
      body: Container(
        decoration: BoxDecoration(
          // ===== Background image =====
          image: DecorationImage(
            image: AssetImage(backgroundImageWithLogo),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              CustomBackButton(
                pageNavigator: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserLoginScreen(),
                  ),
                ),
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
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : 'Please enter a valid email';
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserLoginScreen(),
                              ),
                            );
                          },
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
    );
  }

  // Future resetPassword() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: emailController.text);
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint(e.message);
  //     return false;
  //   }
  // }
}
