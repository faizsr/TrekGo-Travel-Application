import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/auth/domain/repositories/user_auth_repository.dart';

class UserLoginInUsecase {
  final UserAuthRepository userAuthRepository;

  UserLoginInUsecase({required this.userAuthRepository});

  Future<String> call(UserEntity user) async {
    return await userAuthRepository.login(user);
  }
}
