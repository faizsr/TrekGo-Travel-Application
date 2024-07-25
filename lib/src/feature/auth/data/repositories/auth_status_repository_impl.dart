import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source.dart';
import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source_impl.dart';
import 'package:trekgo_project/src/feature/auth/domain/repositories/auth_status_repository.dart';

class AuthStatusRepositoryImpl implements AuthStatusRepository {
  final AuthStatusDataSource authStatusDataSource;

  AuthStatusRepositoryImpl({required this.authStatusDataSource});

  @override
  Future<AuthType> getUserStatus() async =>
      await authStatusDataSource.getAuthStatus();

  @override
  Future<void> saveUserStatus(bool status, AuthType who) async =>
      await authStatusDataSource.saveAuthStatus(status, who);
}
