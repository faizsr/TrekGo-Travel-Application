import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

abstract class UserAuthRepository {
  Future<String> login(UserEntity user);
  Future<String> signUp(UserEntity user);
  Future<void> logout();
  Future<String> forgotPassword(String email);
}
