import 'package:intl/intl.dart';
import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
import 'package:trekgo_project/src/feature/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.password,
    required super.phoneNumber,
    required super.profilePhoto,
    required super.createdDate,
    required super.block,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    final map = json as Map<String, dynamic>;
    return UserModel(
      id: map['uid'],
      name: map['fullname'].toString().capitaliseAllWords(),
      email: map['email'].toString().toLowerCase(),
      phoneNumber: map['mobile_number'],
      profilePhoto: map['profilePic'],
      createdDate: formatTimestamp(map['created_date']),
      block: map['block'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'fullname': name.capitaliseAllWords(),
      'email': email.toLowerCase(),
      'mobile_number': phoneNumber,
      'profilePic': profilePhoto,
      'created_date': createdDate,
      'block': block,
    };
  }
}

String formatTimestamp(String dateTime) {
  var format = DateFormat('d-M-y');
  return format.format(DateTime.parse(dateTime));
}
