import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source.dart';
import 'package:trekgo_project/src/feature/auth/domain/repositories/auth_status_repository.dart';

class AuthStatusRepositoryImpl implements AuthStatusRepository {
  final AuthStatusDataSource authStatusDataSource;

  AuthStatusRepositoryImpl({required this.authStatusDataSource});

  @override
  Future<bool> getUserStatus() async =>
      await authStatusDataSource.getAuthStatus();

  @override
  Future<void> saveUserStatus(bool status) async =>
      await authStatusDataSource.saveAuthStatus(status);
}
