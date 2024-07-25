import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/src/feature/admin/data/data_sources/remote/destinations/manage_destinations_data_source.dart';
import 'package:trekgo_project/src/feature/admin/domain/repositories/manage_destinations_repository.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class ManageDestinationsRepositoryImpl implements ManageDestinationsRepository {
  final ManageDestinationsDataSource manageDestinationsDataSource;

  ManageDestinationsRepositoryImpl({
    required this.manageDestinationsDataSource,
  });

  @override
  void addNewDestination(DestinationEntity destination) {
    return manageDestinationsDataSource.addNewDestination(destination);
  }

  @override
  void deleteDestination(String id) {
    return manageDestinationsDataSource.deleteDestination(id);
  }

  @override
  void updateDestination(DestinationEntity destination, XFile? newImage) {
    return manageDestinationsDataSource.updateDestination(
        destination, newImage);
  }
}
