import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_destinations_repository.dart';

class DeleteDestinationUsecase {
  final ManageDestinationsRepository manageDestinationsRepository;

  DeleteDestinationUsecase({
    required this.manageDestinationsRepository,
  });

  Future<void> call(String id) async {
    return manageDestinationsRepository.deleteDestination(id);
  }
}
