abstract class AuthStatusDataSource {
  Future<bool> getAuthStatus();
  Future<void> saveAuthStatus(bool status);
}
