import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/auth/domain/repositories/user_auth_repository.dart';

class UserSignUpUsecase {
  final UserAuthRepository userAuthRepository;

  UserSignUpUsecase({required this.userAuthRepository});

  Future<String> call(UserEntity user) async {
    return await userAuthRepository.signUp(user);
  }
}
