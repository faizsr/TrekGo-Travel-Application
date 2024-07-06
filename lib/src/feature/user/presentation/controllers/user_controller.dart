import 'package:flutter/material.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/user/domain/usecases/get_user_details_usecase.dart';
import 'package:trekgo_project/src/feature/user/domain/usecases/update_user_details_usecase.dart';

class UserController extends ChangeNotifier {
  final GetUserDetailsUsecase getUserDetailsUsecase;
  final UpdateUserDetailsUsecase updateUserDetailsUsecase;

  UserController({
    required this.getUserDetailsUsecase,
    required this.updateUserDetailsUsecase,
  });

  Stream<UserEntity> getUserDetails() {
    return getUserDetailsUsecase.call();
  }

  updateUserDetails(UserEntity user) async {
    await updateUserDetailsUsecase.call(user);
  }
}
