import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/button.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/help_text.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/title.dart';
import 'package:trekmate_project/widgets/reusable_widgets/back_button.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String fullName = '';
  String email = '';
  String password = '';
  bool isButtonEnable = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
              // ===== Back button =====
              CustomBackButton(
                pageNavigator: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserLoginScreen(),
                  ),
                ),
              ),

              // ===== Background container =====
              Align(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.8,
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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ===== Title =====
                        const TitleWidget(
                          mainText: 'Sign Up',
                          mainTextSize: 30,
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        // ===== Full name field =====
                        TextFieldWidget(
                          fieldTitle: 'Full Name',
                          fieldHintText: 'Enter your full name...',
                          onChanged: (val) {
                            fullName = val;
                            debugPrint(fullName);
                            setState(() {
                              isButtonEnable = fullName.isNotEmpty &&
                                  email.isNotEmpty &&
                                  password.isNotEmpty;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a name'),
                                ),
                              );
                              return;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // ===== Email field =====
                        TextFieldWidget(
                          fieldTitle: 'Email Address',
                          fieldHintText: 'Enter your email address...',
                          onChanged: (val) {
                            email = val;
                            debugPrint(email);
                            setState(() {
                              isButtonEnable = fullName.isNotEmpty &&
                                  email.isNotEmpty &&
                                  password.isNotEmpty;
                            });
                          },
                          validator: (val) {
                            if ((RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(val!))) {
                              return null;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid email'),
                                ),
                              );
                              return;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // ===== Create password field =====
                        TextFieldWidget(
                          fieldTitle: 'Create Password',
                          fieldHintText: 'Enter a strong password...',
                          obscureText: true,
                          onChanged: (val) {
                            password = val;
                            debugPrint(password);
                            setState(() {
                              isButtonEnable = fullName.isNotEmpty &&
                                  email.isNotEmpty &&
                                  password.isNotEmpty;
                            });
                          },
                          validator: (val) {
                            if (val!.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Password must be at least 6 character'),
                                ),
                              );
                              return;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        // ===== Sign Up button =====
                        ButtonsWidget(
                          buttonText: _isLoading ? '' : 'SIGN UP',
                          buttonOnPressed: isButtonEnable
                              ? () {
                                  userSignUp();
                                }
                              : null,
                          loadingWidget: _isLoading
                              ? const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(
                          height: 35,
                        ),

                        // ===== Help text (login in) =====
                        InkWell(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserLoginScreen(),
                            ),
                          ),
                          child: const HelpTextWidget(
                            firstText: "Already Have An Account? ",
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

  // ===== Function for user sign up =====
  userSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(
              fullName.trim(), email.trim(), password.trim(), context)
          .then(
        (value) async {
          if (value == true && email != 'adminlogin@gmail.com') {
            debugPrint('Account created');

            await HelperFunctions.saveUserLoggedInStatus(true);
            await HelperFunctions.saveUserFullName(fullName);
            await HelperFunctions.saveUserEmail(email);

            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created successfully'),
              ),
            );
            setState(() {
              _isLoading = false;
            });
          } else {
            setState(() {
              _isLoading = false;
            });
            debugPrint('Account not created');
          }
        },
      );
    }
  }
}
