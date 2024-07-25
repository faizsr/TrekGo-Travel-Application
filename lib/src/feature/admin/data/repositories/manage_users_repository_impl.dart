import 'package:trekgo_project/src/feature/admin/data/data_sources/remote/users/manage_users_data_source.dart';
import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_users_repository.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class ManageUsersRepositoryImpl implements ManageUsersRepository {
  final ManageUsersDataSource manageUserDataSource;

  ManageUsersRepositoryImpl({required this.manageUserDataSource});

  @override
  Stream<List<UserEntity>> fetchAllUsers() =>
      manageUserDataSource.fetchAllUsers();

  @override
  Future<void> blockUser(String id) => manageUserDataSource.blockUser(id);

  @override
  Future<void> unblockUser(String id) => manageUserDataSource.unblockUser(id);
}
