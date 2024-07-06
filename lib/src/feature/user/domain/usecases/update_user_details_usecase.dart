import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/user/domain/repositories/user_repository.dart';

class UpdateUserDetailsUsecase {
  final UserRepository userRepository;

  UpdateUserDetailsUsecase({required this.userRepository});

  Future<void> call(UserEntity user) async {
    await userRepository.updateUserDetails(user);
  }
}
