class UserEntity {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String profilePhoto;

  UserEntity({
    this.id = '',
    this.name = '',
    required this.email,
    this.password = '',
    this.phoneNumber = '',
    this.profilePhoto = '',
  });
}
