import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_users_repository.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class FetchAllUsersUsecase {
  final ManageUsersRepository manageUsersRepository;

  FetchAllUsersUsecase({required this.manageUsersRepository});

  Stream<List<UserEntity>> call() => manageUsersRepository.fetchAllUsers();
}
