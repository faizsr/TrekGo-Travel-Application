import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/auth_db_function.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/screens/user/widget/widgets.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/reusable_widgets/alerts_and_navigates.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final adminIdController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String adminId = '';
  String email = '';
  String password = '';
  bool isLoading = false;
  bool isButtonEnable = false;
  bool obscureText = false;

  AuthService authService = AuthService();
  

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
                      // ===== Back button =====
                      CustomBackButton(
                        pageNavigator: () =>
                            nextScreenReplace(context, const UserLoginScreen()),
                      ),

                      // ===== Background container =====
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.9,
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
                                const Padding(
                                  padding: EdgeInsets.only(top: 25),
                                  child: TitleWidget(
                                    mainText: 'Admin Login',
                                    mainTextSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                // ===== Admin ID field =====
                                TextFieldWidget(
                                  controller: adminIdController,
                                  fieldTitle: 'Admin ID',
                                  fieldHintText: 'Enter Admin ID...',
                                  onChanged: (val) {
                                    adminId = val;
                                    debugPrint(adminId);
                                    setState(() {
                                      isButtonEnable = adminId.isNotEmpty &&
                                          email.isNotEmpty &&
                                          password.isNotEmpty;
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      customSnackbar(
                                          context,
                                          'Please enter a valid id',
                                          20,
                                          20,
                                          20);
                                      return;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                // ===== Email address field =====
                                TextFieldWidget(
                                  controller: emailController,
                                  fieldTitle: 'Email Address',
                                  fieldHintText: 'Enter your email address...',
                                  onChanged: (val) {
                                    email = val;
                                    debugPrint(email);
                                    setState(() {
                                      isButtonEnable = adminId.isNotEmpty &&
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
                                          20,
                                          20);
                                      return;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                // ===== Password field =====
                                TextFieldWidget(
                                  controller: passwordController,
                                  obscureText: !obscureText,
                                  suffixIcon: passwordController.text.isNotEmpty ? InkWell(
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
                                  ) : null,
                                  fieldTitle: 'Password',
                                  fieldHintText: 'Enter your password...',
                                  onChanged: (val) {
                                    password = val;
                                    debugPrint(password);
                                    setState(() {
                                      isButtonEnable = adminId.isNotEmpty &&
                                          email.isNotEmpty &&
                                          password.isNotEmpty;
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.length < 6) {
                                      customSnackbar(
                                          context,
                                          'Wrong password',
                                          20,
                                          20,
                                          20);
                                      return;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                // ===== Login Button =====
                                ButtonsWidget(
                                  buttonText: isLoading ? '' : 'LOGIN',
                                  buttonOnPressed: isButtonEnable
                                      ? () => adminLogin(
                                            formKey: _formKey,
                                            authService: authService,
                                            email: email,
                                            password: password,
                                            setLoadingCallback: setLoading,
                                            context: context,
                                          )
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
                              ],
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
