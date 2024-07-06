import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/forgot_password_usecase.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/user_logout_usecase.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/user_sign_up_usecase.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/auth_status_usecase.dart';
import 'package:trekgo_project/src/feature/auth/domain/use_cases/user_login_usecase.dart';

class AuthController extends ChangeNotifier {
  final UserLoginInUsecase userLoginInUsecase;
  final UserSignUpUsecase userSignUpUsecase;
  final UserLogoutUsecase userLogoutUsecase;
  final ForgotPasswordUsecase forgotPasswordUsecase;
  final AuthStatusUsecase authStatusUsecase;

  AuthController({
    required this.userLoginInUsecase,
    required this.userSignUpUsecase,
    required this.userLogoutUsecase,
    required this.forgotPasswordUsecase,
    required this.authStatusUsecase,
  });

  bool isLoading = false;
  String result = '';

  Future<void> login(UserEntity user) async {
    log('Is data on controller: ${user.email} ${user.password}');
    isLoading = true;
    notifyListeners();

    final response = await userLoginInUsecase.call(user);
    result = response;
    notifyListeners();
    log('Result from signing in from controller: $result');
    await authStatusUsecase.save(true);

    isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(UserEntity user) async {
    isLoading = true;
    notifyListeners();

    final response = await userSignUpUsecase.call(user);
    result = response;
    notifyListeners();
    log('Result from signing up from controller: $result');
    await authStatusUsecase.save(true);

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await userLogoutUsecase.call();
    await authStatusUsecase.save(false);
    notifyListeners();
  }

  Future<void> forgotPassword(String email) async {
    isLoading = true;
    notifyListeners();

    final response = await forgotPasswordUsecase.call(email);
    result = response;
    notifyListeners();
    log('Result from signing up from controller: $result');
    await authStatusUsecase.save(true);

    isLoading = false;
    notifyListeners();
  }
}
