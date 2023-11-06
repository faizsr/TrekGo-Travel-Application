import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/User/forgot_password_screen.dart';
import 'package:trekmate_project/screens/User/user_login_screen.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/button.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/title.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/back_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          //  Background Image

          image: DecorationImage(
            image: AssetImage(backgroundImageWithLogo),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //Back Button

              CustomBackButton(
                pageNavigator: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                ),
              ),

              //Background Container
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.all(25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: TitleWidget(
                          mainText: 'Reset Your Password',
                          mainTextSize: 20,
                          isMainTextWeight: true,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // Admin ID Field
                      const TextFieldWidget(
                        fieldTitle: 'Current Password',
                        fieldHintText: 'Enter your current password...',
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Email Address Field
                      const TextFieldWidget(
                          fieldTitle: 'Email Address',
                          fieldHintText: 'Enter your email address...'),
                      const SizedBox(
                        height: 15,
                      ),

                      //Passwordd Field
                      const TextFieldWidget(
                          fieldTitle: 'Password',
                          fieldHintText: 'Enter your password...'),
                      const SizedBox(
                        height: 23,
                      ),

                      //Login Button
                      // ButtonsWidget(
                      //   buttonText: 'RESET PASSWORD',
                      //   buttonWidth: MediaQuery.of(context).size.width / 2.4,
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),

                      ButtonsWidget(
                        buttonText: 'RESET PASSWORD',
                        buttonWidth: MediaQuery.of(context).size.width / 2.4,
                        buttonOnPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const UserLoginScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
