import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/auth_db_function.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/alerts_and_navigators/alerts_and_navigates.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/widgets.dart';

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
  String? imageUrl;
  bool obscureText = false;

  void setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.973,
          width: MediaQuery.of(context).size.width,
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
                    // alignment: AlignmentDirectional.center,
                    children: [
                      // ===== Back button =====
                      CustomBackButton(
                        pageNavigator: () => nextScreenReplace(
                          context,
                          const UserLoginScreen(),
                        ),
                      ),

                      // ===== Background container =====
                      Align(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.556,
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
                                      customSnackbar(context,
                                          'Please enter a name', 20, 55, 55);
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
                                  height: 15,
                                ),

                                // ===== Create password field =====
                                TextFieldWidget(
                                  fieldTitle: 'Create Password',
                                  fieldHintText: 'Enter a strong password...',
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
                                    debugPrint(password);
                                    setState(() {
                                      isButtonEnable = fullName.isNotEmpty &&
                                          email.isNotEmpty &&
                                          password.isNotEmpty;
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.length < 6) {
                                      customSnackbar(
                                          context,
                                          'Passowrd must be at least 6 character',
                                          20,
                                          55,
                                          55);
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
                                          userSignUp(
                                            formKey: _formKey,
                                            authService: authService,
                                            fullName: fullName,
                                            email: email,
                                            password: password,
                                            isLoading: _isLoading,
                                            setLoadingCallback: setLoading,
                                            context: context,
                                          );
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
                                  height: 25,
                                ),

                                // ===== Help text (login in) =====
                                InkWell(
                                  onTap: () => nextScreenReplace(
                                      context, const UserLoginScreen()),
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
