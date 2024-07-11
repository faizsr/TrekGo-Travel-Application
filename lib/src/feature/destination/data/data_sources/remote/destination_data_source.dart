import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

abstract class DestinationDataSource {
  Stream<List<DestinationEntity>> fetchPopular();
  Stream<List<DestinationEntity>> fetchRecommended();
}
