import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trekgo_project/changer/assets.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/auth_status_usecase.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/main_page.dart';
import 'package:trekgo_project/src/feature/auth/presentation/views/user/user_login_page.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/injection_container.dart' as di;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ===== Body =====
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFE5E6F6),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Image.asset(
            appLogo,
            width: 230,
          ),
        ),
      ),
    );
  }

  // ===== Function for navigating based on roles =====
  Future<void> checkUserStatus() async {
    final delay = Future.delayed(const Duration(milliseconds: 2500));
    final authStatusUseCase = di.getIt<AuthStatusUsecase>();
    final userSignIn = await authStatusUseCase.get();
    log('UserSignIn: $userSignIn');
    if (userSignIn) {
      log('On Main');
      await delay;
      nextScreenRemoveUntil(context, const MainPage());
    } else {
      log('On Login');
      await delay;
      nextScreenRemoveUntil(context, const UserLoginPage());
    }
  }
}
