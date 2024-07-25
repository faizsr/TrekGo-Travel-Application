import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_users_repository.dart';

class UnblockUserUsecase {
  final ManageUsersRepository manageUsersRepository;

  UnblockUserUsecase({required this.manageUsersRepository});

  Future<void> call(String id) => manageUsersRepository.unblockUser(id);
}
