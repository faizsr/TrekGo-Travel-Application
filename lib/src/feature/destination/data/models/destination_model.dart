import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class DestinationModel extends DestinationEntity {
  DestinationModel({
    required super.id,
    required super.name,
    required super.image,
    required super.category,
    required super.state,
    required super.rating,
    required super.description,
    required super.location,
    required super.mapUrl,
  });

  factory DestinationModel.fromJson(Map<String, dynamic>? json) {
    final map = json as Map<String, dynamic>;
    return DestinationModel(
      id: map['id'] ?? '',
      name: map['place_name'],
      image: map['place_image'],
      category: map['place_category'],
      state: map['place_state'],
      rating: map['place_rating'],
      description: map['place_description'],
      location: map['place_location'],
      mapUrl: map['place_map'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place_name': name,
      'place_category': category,
      'place_state': state,
      'place_rating': rating,
      'place_description': description,
      'place_location': location,
      'place_map': mapUrl,
    };
  }
}
