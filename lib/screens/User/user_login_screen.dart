import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/Admin/admin_login_screen.dart';
import 'package:trekmate_project/screens/user/forgot_password_screen.dart';
import 'package:trekmate_project/screens/user/user_signup_screen.dart';
import 'package:trekmate_project/screens/Bottom%20page%20navigator/bottom_navigation_bar.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/alert_dialog/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/alert_dialog/custom_alert.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/button.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/help_text.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/title.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  String email = '';
  String password = '';
  AuthService authService = AuthService();
  bool validate = false;
  bool isButtonEnable = false;

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
          padding: const EdgeInsets.only(bottom: 30),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              // ===== Background container =====
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
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ===== Title =====
                        GestureDetector(
                          onLongPress: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const AdminLoginScreen(),
                            //   ),
                            // );
                            nextScreen(context, const AdminLoginScreen());
                          },
                          child: const TitleWidget(
                            mainText: 'login',
                            mainTextSize: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),

                        // ===== Email field =====
                        TextFieldWidget(
                          fieldTitle: 'Email Address',
                          fieldHintText: 'Enter your registered email...',
                          onChanged: (val) {
                            email = val;
                            debugPrint(email);
                            setState(() {
                              isButtonEnable =
                                  email.isNotEmpty && password.isNotEmpty;
                            });
                          },
                          validator: (val) {
                            if ((RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(val!))) {
                              return null;
                            } else {
                              customSnackbar(context,
                                  'Please enter a valid email', 150, 55, 55);
                              return;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // ===== Password Field =====
                            TextFieldWidget(
                              fieldTitle: 'Password',
                              fieldHintText: 'Enter you password...',
                              obscureText: true,
                              onChanged: (val) {
                                password = val;
                                debugPrint(val);
                                setState(() {
                                  isButtonEnable =
                                      email.isNotEmpty && password.isNotEmpty;
                                });
                              },
                              validator: (val) {
                                if (val!.length < 6) {
                                  customSnackbar(
                                      context,
                                      'Password must be at least 6 characters!',
                                      150,
                                      55,
                                      55);
                                  return;
                                } else {
                                  return null;
                                }
                              },
                            ),

                            // ===== Forgot Password =====
                            InkWell(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(right: 26, top: 10),
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0x60000000),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // ===== Login Button =====
                        ButtonsWidget(
                          buttonText: isLoading ? '' : 'LOGIN',
                          buttonOnPressed: isButtonEnable
                              ? () {
                                  userLogin();
                                }
                              : null,
                          loadingWidget: isLoading
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
                          height: 25,
                        ),

                        // ===== Help text (sign up) =====
                        GestureDetector(
                          onTap: () => nextScreenReplace(
                              context, const UserSignUpScreen()),
                          child: HelpTextWidget(
                            firstText: "Don't Have An Account? ",
                            secondText: 'Sign Up?',
                            onPressedSignUp: () => nextScreenReplace(
                                context, const UserSignUpScreen()),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // GestureDetector(
                        //   onTap: () => Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const UserSignUpScreen(),
                        //     ),
                        //   ),
                        //   child: HelpTextWidget(
                        //     firstText: "Are you a admin? ",
                        //     secondText: 'Login?',
                        //     onPressedSignUp: () => Navigator.of(context)
                        //         .pushReplacement(MaterialPageRoute(
                        //       builder: (context) => const UserSignUpScreen(),
                        //     )),
                        //   ),
                        // ),
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

// ===== User Login Function =====
  userLogin() async {
    if (formkey.currentState!.validate() && password.length > 5) {
      setState(() {
        isLoading = true;
      });
      await authService.loginUserWithEmailandPassword(email, password).then(
        (value) async {
          if (value == true && email != 'adminlogin@gmail.com') {
            debugPrint('login succesfully');
            QuerySnapshot snapshot = await DatabaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);

            await HelperFunctions.saveUserLoggedInStatus(true);
            await HelperFunctions.saveUserFullName(
                snapshot.docs[0]["fullname"]);
            await HelperFunctions.saveUserEmail(email);

            // ignore: use_build_context_synchronously
            nextScreenRemoveUntil(context,
                const NavigationBottomBar(isAdmin: false, isUser: true));
          } else {
            setState(() {
              isLoading = false;
            });

            showDialog(
              context: context,
              builder: (context) {
                return const CustomAlertDialog(
                  title: 'Incorrect Login Details',
                  description:
                      'The email and password you entered is incorrect. Please try again.',
                  disableActionBtn: true,
                  popBtnText: 'OK',
                );
              },
            );
            debugPrint('Error login in');
          }
        },
      );
    }
  }
}
