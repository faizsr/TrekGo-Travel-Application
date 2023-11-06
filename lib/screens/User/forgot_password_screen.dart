import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/screens/User/reset_password_screen.dart';
import 'package:trekmate_project/screens/User/user_login_screen.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/button.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/help_text.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/title.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/back_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title
                      const TitleWidget(
                        mainText: 'Forgot Password?',
                        mainTextSize: 24,
                        isMainTextWeight: true,
                      ),
                      const SizedBox(
                        height: 35,
                      ),

                      //Email Address Field
                      const TextFieldWidget(
                        fieldTitle: 'Email Address',
                        fieldHintText: 'Enter a valid email address...',
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      //Confirm Button
                      ButtonsWidget(
                        buttonText: 'CONFIRM',
                        isOutlinedButton: true,
                        buttonWidth: 180,
                        buttonOnPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //Help Text
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserLoginScreen(),
                          ),
                        ),
                        child: const HelpTextWidget(
                          firstText: "Back To ",
                          secondText: 'Login?',
                        ),
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
