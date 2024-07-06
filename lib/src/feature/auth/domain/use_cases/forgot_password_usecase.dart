import 'package:trekgo_project/src/feature/auth/domain/repositories/user_auth_repository.dart';

class ForgotPasswordUsecase {
  final UserAuthRepository userAuthRepository;

  ForgotPasswordUsecase({required this.userAuthRepository});

  Future<String> call(String email) async {
    return await userAuthRepository.forgotPassword(email);
  }
}
