import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/user/block_user_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/user/fetch_all_users_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/user/unblock_user_usecase.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class ManageUserController extends ChangeNotifier {
  final FetchAllUsersUsecase fetchAllUsersUsecase;
  final BlockUserUsecase blockUserUsecase;
  final UnblockUserUsecase unblockUserUsecase;

  ManageUserController({
    required this.fetchAllUsersUsecase,
    required this.blockUserUsecase,
    required this.unblockUserUsecase,
  });

  List<UserEntity> users = [];

  fetchAllUser() {
    final dataStream = fetchAllUsersUsecase.call();

    dataStream.listen(
      (streamUsers) {
        users = streamUsers;
        notifyListeners();
      },
    ).onError((error) {
      log('Error from fetching all users: $error');
      notifyListeners();
    });
  }

  blockUser(String id) async {
    await blockUserUsecase.call(id);
  }

  unblockUser(String id) async {
    await unblockUserUsecase.call(id);
  }
}
