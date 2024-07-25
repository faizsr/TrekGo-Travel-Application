import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source_impl.dart';

abstract class AuthStatusDataSource {
  Future<AuthType> getAuthStatus();
  Future<void> saveAuthStatus(bool status, AuthType who);
}
