import 'package:trekgo_project/src/feature/auth/domain/repositories/user_auth_repository.dart';

class UserLogoutUsecase {
  final UserAuthRepository userAuthRepository;

  UserLogoutUsecase({required this.userAuthRepository});

  Future<void> call() async {
    return await userAuthRepository.logout();
  }
}
