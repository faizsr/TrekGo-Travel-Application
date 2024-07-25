import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/user/domain/usecases/get_user_details_usecase.dart';
import 'package:trekgo_project/src/feature/user/domain/usecases/update_user_details_usecase.dart';

class UserController extends ChangeNotifier {
  final GetUserDetailsUsecase getUserDetailsUsecase;
  final UpdateUserDetailsUsecase updateUserDetailsUsecase;

  UserEntity? user;
  bool isLoading = false;

  UserController({
    required this.getUserDetailsUsecase,
    required this.updateUserDetailsUsecase,
  });

  getUserDetails() {
    isLoading = true;
    notifyListeners();

    final dataStream = getUserDetailsUsecase.call();
    dataStream.listen(
      (userEntity) {
        user = userEntity;
        isLoading = false;
        log('user: ${user!.email}');
        notifyListeners();
      },
    ).onError((error) {
      isLoading = false;
      notifyListeners();
    });
  }

  updateUserDetails(UserEntity user) async {
    await updateUserDetailsUsecase.call(user);
  }
}
