import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';
import 'package:trekgo_project/src/feature/destination/domain/repositories/destination_repository.dart';

class GetRecommendedDestinationUsecase {
  final DestinationRepository destinationRepository;

  GetRecommendedDestinationUsecase({required this.destinationRepository});

  Stream<List<DestinationEntity>> call() {
    return destinationRepository.getRecommended();
  }
}
