import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Stream<UserEntity> getUserDetails();
  Future<void> updateUserDetails(UserEntity user);
}
