import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/Bottom%20page%20navigator/bottom_navigation_bar.dart';
import 'package:trekmate_project/screens/User/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/button.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/Login%20and%20signup%20widgets/title.dart';
import 'package:trekmate_project/widgets/Reusable%20widgets/back_button.dart';

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
                          },
                          validator: (val) {
                            if (val == null) {
                              return 'This field is required';
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
                          height: 15,
                        ),
                  
                        // ===== Password field =====
                        TextFieldWidget(
                          controller: passwordController,
                          fieldTitle: 'Password',
                          fieldHintText: 'Enter your password...',
                          onChanged: (val) {
                            password = val;
                            debugPrint(password);
                          },
                          validator: (val) {
                            if (val!.length < 6) {
                              return 'Password must be at least 6 character';
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
                          buttonText: 'LOGIN',
                          buttonOnPressed: () => adminLogin(),
                        ),
                        const SizedBox(
                          height: 25,
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

  adminLogin() async {
    if (_formKey.currentState!.validate()) {
      if (adminIdController.text == 'main admin' &&
          emailController.text == 'mainadmin@gmail.com' &&
          passwordController.text == 'admin@321') {
        await HelperFunctions.saveAdminLoggedInStatus(true);
        await HelperFunctions.saveAdminId(adminIdController.text);
        await HelperFunctions.saveAdminEmail(emailController.text);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const NavigationBottomBar()),
            (route) => false);
      }
    }
  }
}
