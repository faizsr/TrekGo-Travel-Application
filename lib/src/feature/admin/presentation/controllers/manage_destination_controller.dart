import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/destination/add_destination_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/destination/delete_destination_usecase.dart';
import 'package:trekgo_project/src/feature/admin/domain/usecases/destination/update_destination_usecase.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class ManageDestinationController extends ChangeNotifier {
  final AddDestinationUsecase addDestinationUsecase;
  final UpdateDestinationUsecase updateDestinationUsecase;
  final DeleteDestinationUsecase deleteDestinationUsecase;

  ManageDestinationController({
    required this.addDestinationUsecase,
    required this.updateDestinationUsecase,
    required this.deleteDestinationUsecase,
  });

  bool isLoading = false;

  Future<void> addNewDestination(DestinationEntity destination) async {
    isLoading = true;
    notifyListeners();
    await addDestinationUsecase.call(destination);
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateDestination(
      DestinationEntity destination, XFile? newImage) async {
    isLoading = true;
    notifyListeners();
    await updateDestinationUsecase.call(destination, newImage);
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteDestination(String id) async {
    await deleteDestinationUsecase.call(id);
  }
}
