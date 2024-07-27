import 'package:trekgo_project/src/feature/destination/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.user,
    required super.reviewText,
    required super.rating,
    required super.createdDate,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        user: json['user'],
        reviewText: json['review_text'],
        rating: json['rating'],
        createdDate: json['created_date'],
      );

  Map<String, dynamic> toMap() => {
        'user': user,
        'review_text': reviewText,
        'rating': rating,
        'created_date': createdDate,
      };
}
