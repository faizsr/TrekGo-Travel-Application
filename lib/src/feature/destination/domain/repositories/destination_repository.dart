import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

abstract class DestinationRepository {
  Stream<List<DestinationEntity>> getPopular();
  Stream<List<DestinationEntity>> getRecommended();
}
