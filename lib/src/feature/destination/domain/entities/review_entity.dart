import 'package:trekgo_project/src/feature/user/data/models/user_model.dart';

class ReviewEntity {
  final UserModel user;
  final String reviewText;
  final double rating;
  final String createdDate;

  ReviewEntity({
    required this.user,
    required this.reviewText,
    required this.rating,
    required this.createdDate,
  });
}
