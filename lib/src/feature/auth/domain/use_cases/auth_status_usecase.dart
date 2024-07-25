import 'package:trekgo_project/src/feature/auth/data/data_sources/local/auth_status_data_source_impl.dart';
import 'package:trekgo_project/src/feature/auth/domain/repositories/auth_status_repository.dart';

class AuthStatusUsecase {
  final AuthStatusRepository authStatusRepository;

  AuthStatusUsecase({required this.authStatusRepository});

  Future<AuthType> get() async {
    return await authStatusRepository.getUserStatus();
  }

  Future<void> save(bool status, AuthType who) async {
    await authStatusRepository.saveUserStatus(status, who);
  }
}
