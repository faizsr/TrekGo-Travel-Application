import 'package:trekgo_project/src/feature/auth/domain/repositories/auth_status_repository.dart';

class AuthStatusUsecase {
  final AuthStatusRepository authStatusRepository;

  AuthStatusUsecase({required this.authStatusRepository});

  Future<bool> get() async {
    return await authStatusRepository.getUserStatus();
  }

  Future<void> save(bool status) async {
    await authStatusRepository.saveUserStatus(status);
  }
}
