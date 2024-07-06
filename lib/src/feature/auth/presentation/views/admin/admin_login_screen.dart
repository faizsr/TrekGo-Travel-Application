import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/assets.dart';
// import 'package:trekgo_project/changer/helper/auth_db_function.dart';
import 'package:trekgo_project/changer/service/auth_service.dart';
// import 'package:trekgo_project/src/feature/auth/presentation/views/user/user_login_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/widgets/custom_text_field.dart';
// import 'package:trekgo_project/src/feature/auth/presentation/widgets/widgets.dart';
// import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';

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
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      // ===== Back button =====
                      // CustomBackButton(
                      //   pageNavigator: () =>
                      //       nextScreenReplace(context, const UserLoginPage()),
                      // ),

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
                                // const Padding(
                                //   padding: EdgeInsets.only(top: 25),
                                //   child: TitleWidget(
                                //     mainText: 'Admin Login',
                                //     mainTextSize: 25,
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 30,
                                ),

                                // ===== Admin ID field =====
                                CustomTextField(
                                  controller: adminIdController,
                                  title: 'Admin ID',
                                  hintText: 'Enter Admin ID...',
                                  onChanged: (val) {},
                                  validator: (val) => null,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                // ===== Email address field =====
                                CustomTextField(
                                  controller: emailController,
                                  title: 'Email Address',
                                  hintText: 'Enter your email address...',
                                  onChanged: (val) {},
                                  validator: (val) => null,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                                // ===== Password field =====
                                CustomTextField(
                                  controller: passwordController,
                                  title: 'Password',
                                  hintText: 'Enter your password...',
                                  onChanged: (val) {},
                                  validator: (val) => null,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                // ===== Login Button =====
                                // ButtonsWidget(
                                //   buttonText: isLoading ? '' : 'LOGIN',
                                //   buttonOnPressed: isButtonEnable
                                //       ? () => adminLogin(
                                //             formKey: _formKey,
                                //             authService: authService,
                                //             email: email,
                                //             password: password,
                                //             setLoadingCallback: setLoading,
                                //             context: context,
                                //           )
                                //       : null,
                                //   loadingWidget: isLoading
                                //       ? const SizedBox(
                                //           width: 15,
                                //           height: 15,
                                //           child: Center(
                                //             child: CircularProgressIndicator(
                                //               color: Colors.white,
                                //               strokeWidth: 2,
                                //             ),
                                //           ),
                                //         )
                                //       : null,
                                // ),
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
