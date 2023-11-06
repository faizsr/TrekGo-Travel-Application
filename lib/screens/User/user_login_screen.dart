import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/Admin/admin_login_screen.dart';
import 'package:trekmate_project/screens/User/forgot_password_screen.dart';
import 'package:trekmate_project/screens/User/user_signup_screen.dart';
import 'package:trekmate_project/screens/Bottom%20page%20navigator/bottom_navigation_bar.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/button.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/help_text.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/title.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  AuthService authService = AuthService();

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
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AdminLoginScreen(),
                            ),
                          ),
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
                          },
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : 'Please enter a valid email';
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
                              onChanged: (val) {
                                password = val;
                                debugPrint(val);
                              },
                              validator: (val) {
                                if (val!.length < 6) {
                                  return 'Password must be at least 6 characterz';
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
                                  builder: (context) =>
                                      const ForgotPasswordScreen(),
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
                            buttonText: 'LOGIN',
                            buttonOnPressed: () {
                              userLogin();
                            }
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const NavigationBottomBar(),
                            //   ),
                            // ),
                            ),
                        const SizedBox(
                          height: 35,
                        ),

                        // ===== Help text (sign up) =====
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserSignUpScreen(),
                            ),
                          ),
                          child: HelpTextWidget(
                            firstText: "Don't Have An Account? ",
                            secondText: 'Sign Up?',
                            onPressedSignUp: () =>
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => const UserSignUpScreen(),
                            )),
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

// ===== User Login Function =====
  userLogin() async {
    if (formkey.currentState!.validate()) {
      await authService.loginUserWithEmailandPassword(email, password).then(
        (value) async {
          if (value == true) {
            debugPrint('login succesfully');
            QuerySnapshot snapshot = await DatabaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(email);

            await HelperFunctions.saveUserLoggedInStatus(true);
            await HelperFunctions.saveUserFullName(
                snapshot.docs[0]["fullname"]);
            await HelperFunctions.saveUserEmail(email);

            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const NavigationBottomBar()),
                (route) => false);
          } else {
            debugPrint('Error login in');
          }
        },
      );
    }
  }
}
