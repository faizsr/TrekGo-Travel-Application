import 'package:trekgo_project/src/feature/destination/data/models/destination_model.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class DestinationMapper {
  static DestinationEntity mapToEntity(DestinationModel model) {
    return DestinationEntity(
      id: model.id,
      name: model.name,
      image: model.image,
      category: model.category,
      description: model.description,
      location: model.location,
      mapUrl: model.mapUrl,
      rating: model.rating,
      state: model.state,
    );
  }

  static DestinationModel mapToModel(DestinationEntity entity) {
    return DestinationModel(
      id: entity.id,
      name: entity.name,
      image: entity.image,
      category: entity.category,
      description: entity.description,
      location: entity.location,
      mapUrl: entity.mapUrl,
      rating: entity.rating,
      state: entity.state,
    );
  }
}
