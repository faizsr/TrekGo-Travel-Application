import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trekmate_project/assets.dart';
import 'package:trekmate_project/helper/helper_functions.dart';
import 'package:trekmate_project/screens/Bottom%20page%20navigator/bottom_navigation_bar.dart';
import 'package:trekmate_project/screens/user/user_login_screen.dart';
import 'package:trekmate_project/service/auth_service.dart';
import 'package:trekmate_project/service/database_service.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/button.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/text_form_field.dart';
import 'package:trekmate_project/widgets/login_signup_widgets/title.dart';
import 'package:trekmate_project/widgets/reusable_widgets/back_button.dart';

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
                            setState(() {
                              isButtonEnable = adminId.isNotEmpty &&
                                  email.isNotEmpty &&
                                  password.isNotEmpty;
                            });
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

                        // ===== Password field =====
                        TextFieldWidget(
                          controller: passwordController,
                          obscureText: true,
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

                        // ===== Login Button =====
                        ButtonsWidget(
                          buttonText: isLoading ? '' : 'LOGIN',
                          buttonOnPressed:
                              isButtonEnable ? () => adminLogin() : null,
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
            ],
          ),
        ),
      ),
    );
  }

  // ===== Function for admin login =====
  adminLogin() async {
    if (_formKey.currentState!.validate() && password.length > 5) {
      setState(() {
        isLoading = true;
      });
      await authService.loginAdminWithEmailandPassword(email, password).then(
        (value) async {
          if (value == true && email == 'adminlogin@gmail.com') {
            QuerySnapshot snapshot = await DatabaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingAdminData(email);

            // saving the values to our shared preferences
            await HelperFunctions.saveAdminLoggedInStatus(true);
            await HelperFunctions.saveAdminEmail(email);
            await HelperFunctions.saveAdminId(snapshot.docs[0]["admin_id"]);

            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const NavigationBottomBar(
                    isAdmin: true,
                    isUser: false,
                  ),
                ),
                (route) => false);
          } else {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Enter login details correctly'),
              ),
            );
            debugPrint('Enter admin id correctly');
            debugPrint('$context');
          }
        },
      );
    }
  }
}
