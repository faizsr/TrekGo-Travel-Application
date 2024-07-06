import 'package:trekgo_project/src/feature/user/data/models/user_model.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class UserMapper {
  static UserEntity mapToEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      password: model.password,
      phoneNumber: model.phoneNumber,
      profilePhoto: model.profilePhoto,
    );
  }

  static UserModel mapToModel(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      password: entity.password,
      phoneNumber: entity.phoneNumber,
      profilePhoto: entity.profilePhoto,
    );
  }
}
