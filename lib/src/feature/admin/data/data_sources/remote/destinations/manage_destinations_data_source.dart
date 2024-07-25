import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

abstract class ManageDestinationsDataSource {
  void addNewDestination(DestinationEntity destination);
  void updateDestination(DestinationEntity destination, XFile? newImage);
  void deleteDestination(String id);
}
 