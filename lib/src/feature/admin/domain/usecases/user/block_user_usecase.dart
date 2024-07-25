import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_users_repository.dart';

class BlockUserUsecase {
  final ManageUsersRepository manageUsersRepository;

  BlockUserUsecase({required this.manageUsersRepository});

  Future<void> call(String id) => manageUsersRepository.blockUser(id);
}
