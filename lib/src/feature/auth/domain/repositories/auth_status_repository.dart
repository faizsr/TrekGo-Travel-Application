import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source_impl.dart';

abstract class AuthStatusRepository {
  Future<AuthType> getUserStatus();
  Future<void> saveUserStatus(bool status, AuthType who);
}
