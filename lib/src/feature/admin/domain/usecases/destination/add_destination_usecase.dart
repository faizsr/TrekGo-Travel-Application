import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_destinations_repository.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class AddDestinationUsecase {
  final ManageDestinationsRepository manageDestinationsRepository;

  AddDestinationUsecase({
    required this.manageDestinationsRepository,
  });

  Future<void> call(DestinationEntity destination) async {
    return manageDestinationsRepository.addNewDestination(destination);
  }
}
