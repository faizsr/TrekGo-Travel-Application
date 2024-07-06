import 'package:shared_preferences/shared_preferences.dart';
import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source.dart';

class AuthStatusDataSourceImpl extends AuthStatusDataSource {
  final SharedPreferences sharedPreferences;

  AuthStatusDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> getAuthStatus() async {
    final bool? status = sharedPreferences.getBool('SIGNIN');
    return status ?? false;
  }

  @override
  Future<void> saveAuthStatus(bool status) async {
    sharedPreferences.setBool('SIGNIN', status);
  }
}
