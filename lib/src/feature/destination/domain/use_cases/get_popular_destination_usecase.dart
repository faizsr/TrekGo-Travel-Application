import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';
import 'package:trekgo_project/src/feature/destination/domain/repositories/destination_repository.dart';

class GetPopularDestinationUsecase {
  final DestinationRepository destinationRepository;

  GetPopularDestinationUsecase({required this.destinationRepository});

  Stream<List<DestinationEntity>> call() {
    return destinationRepository.getPopular();
  }
}
