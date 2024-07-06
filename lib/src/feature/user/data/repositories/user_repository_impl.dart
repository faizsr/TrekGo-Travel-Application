import 'package:trekgo_project/src/feature/user/data/data_sources/user_remote_data_source.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';
import 'package:trekgo_project/src/feature/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Stream<UserEntity> getUserDetails() {
    return userRemoteDataSource.getUserDetails();
  }

  @override
  Future<void> updateUserDetails(UserEntity user) {
    return userRemoteDataSource.updateUserDetails(user);
  }
}
