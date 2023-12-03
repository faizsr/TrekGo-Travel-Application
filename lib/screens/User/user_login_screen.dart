import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/auth_db_function.dart';
import 'package:trekmate_project/screens/Admin/admin_login_screen.dart';
import 'package:trekmate_project/screens/user/forgot_password_screen.dart';
import 'package:trekmate_project/screens/user/user_signup_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/widgets.dart';

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
  bool obscureText = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                          height: MediaQuery.of(context).size.height * 0.5,
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
                                    nextScreen(
                                        context, const AdminLoginScreen());
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
                                  fieldHintText:
                                      'Enter your registered email...',
                                  onChanged: (val) {
                                    email = val;
                                    debugPrint(email);
                                    setState(() {
                                      isButtonEnable = email.isNotEmpty &&
                                          password.isNotEmpty;
                                    });
                                  },
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
                                          55,
                                          55);
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
                                      obscureText: !obscureText,
                                      suffixIcon: password.isNotEmpty
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  obscureText = !obscureText;
                                                });
                                                // debugPrint('eye pressed $obscureText');
                                              },
                                              child: Icon(
                                                obscureText
                                                    ? MdiIcons.eyeOff
                                                    : MdiIcons.eye,
                                                size: 19,
                                                color: Colors.grey,
                                              ),
                                            )
                                          : null,
                                      onChanged: (val) {
                                        password = val;
                                        debugPrint(val);
                                        setState(() {
                                          isButtonEnable = email.isNotEmpty &&
                                              password.isNotEmpty;
                                        });
                                      },
                                      validator: (val) {
                                        if (val!.length < 6) {
                                          customSnackbar(context,
                                              'Incorrect Password', 20, 55, 55);
                                          return;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),

                                    // ===== Forgot Password =====
                                    InkWell(
                                      onTap: () {
                                        nextScreen(context,
                                            const ForgotPasswordScreen());
                                      },
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(right: 26, top: 10),
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
                                          userLoginFunction(
                                            formKey: formkey,
                                            authService: authService,
                                            email: email,
                                            password: password,
                                            isLoading: isLoading,
                                            setLoadingCallback: setLoading,
                                            context: context,
                                          );
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
                                  onTap: () => nextScreen(
                                      context, const UserSignUpScreen()),
                                  child: HelpTextWidget(
                                    firstText: "Don't Have An Account? ",
                                    secondText: 'Sign Up?',
                                    onPressedSignUp: () => nextScreen(
                                        context, const UserSignUpScreen()),
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
        ),
      ),
    );
  }
}
