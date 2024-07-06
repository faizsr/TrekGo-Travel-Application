import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/user/domain/repositories/user_repository.dart';

class GetUserDetailsUsecase {
  final UserRepository userRepository;

  GetUserDetailsUsecase({required this.userRepository});

  Stream<UserEntity> call() {
    return userRepository.getUserDetails();
  }
}
