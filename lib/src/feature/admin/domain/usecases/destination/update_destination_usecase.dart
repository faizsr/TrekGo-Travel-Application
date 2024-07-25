import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_destinations_repository.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class UpdateDestinationUsecase {
  final ManageDestinationsRepository manageDestinationsRepository;

  UpdateDestinationUsecase({
    required this.manageDestinationsRepository,
  });

  Future<void> call(DestinationEntity destination, XFile? newImage) async {
    return manageDestinationsRepository.updateDestination(
        destination, newImage);
  }
}
