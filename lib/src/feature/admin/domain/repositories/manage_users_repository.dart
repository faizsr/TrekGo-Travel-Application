import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

abstract class ManageUsersRepository {
  Stream<List<UserEntity>> fetchAllUsers();
  Future<void> blockUser(String id);
  Future<void> unblockUser(String id);
}
