import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source.dart';

enum AuthType { user, admin, none }

class AuthStatusDataSourceImpl extends AuthStatusDataSource {
  final SharedPreferences sharedPreferences;

  AuthStatusDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AuthType> getAuthStatus() async {
    final bool user = sharedPreferences.getBool('USER_SIGNIN') ?? false;
    final bool admin = sharedPreferences.getBool('ADMIN_SIGNIN') ?? false;
    if (user) {
      return AuthType.user;
    }
    if (admin) {
      return AuthType.admin;
    }
    return AuthType.none;
  }

  @override
  Future<void> saveAuthStatus(bool status, AuthType who) async {
    if (who == AuthType.user) {
      sharedPreferences.setBool('USER_SIGNIN', status);
    } else if (who == AuthType.admin) {
      sharedPreferences.setBool('ADMIN_SIGNIN', status);
    }
  }
}
