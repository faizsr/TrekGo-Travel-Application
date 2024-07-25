import 'package:trekgo_project/changer/widgets/reusable_widgets/alerts_and_navigates.dart';
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
      name: map['name'].toString().capitaliseAllWords(),
      image: map['image'],
      category: map['category'].toString().capitalise(),
      state: map['state'].toString().capitalise(),
      rating: map['rating'],
      description: map['description'].toString().capitalise(),
      location: map['location'],
      mapUrl: map['map'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.toString().capitaliseAllWords(),
      'category': category.capitalise(),
      'state': state.capitalise(),
      'rating': rating,
      'description': description.capitalise(),
      'location': location.capitalise(),
      'map': mapUrl,
    };
  }
}
