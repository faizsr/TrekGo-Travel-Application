import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.password,
    required super.phoneNumber,
    required super.profilePhoto,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    final map = json as Map<String, dynamic>;
    return UserModel(
      id: map['uid'],
      name: map['fullname'],
      email: map['email'],
      phoneNumber: map['mobile_number'],
      profilePhoto: map['profilePic'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'fullname': name,
      'email': email,
      'mobile_number': phoneNumber,
      'profilePic': profilePhoto,
    };
  }
}
