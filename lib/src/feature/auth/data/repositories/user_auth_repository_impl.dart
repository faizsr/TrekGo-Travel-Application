import 'package:trekgo_project/src/feature/auth/data/data_sources/remote/user_auth_data_source.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/auth/domain/repositories/user_auth_repository.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final UserAuthRemoteDataSource userAuthDataSource;

  UserAuthRepositoryImpl({required this.userAuthDataSource});

  @override
  Future<String> login(UserEntity user) async =>
      await userAuthDataSource.login(user);

  @override
  Future<String> signUp(UserEntity user) async =>
      await userAuthDataSource.signUp(user);

  @override
  Future<void> logout() async => await userAuthDataSource.logout();

  @override
  Future<String> forgotPassword(String email) async =>
      userAuthDataSource.forgotPassword(email);
}
