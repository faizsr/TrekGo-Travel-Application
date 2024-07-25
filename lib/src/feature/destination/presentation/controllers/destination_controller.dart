import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';
import 'package:trekgo_project/src/feature/destination/domain/use_cases/get_popular_destination_usecase.dart';
import 'package:trekgo_project/src/feature/destination/domain/use_cases/get_recommended_destination_usecase.dart';

class DestinationController extends ChangeNotifier {
  final GetRecommendedDestinationUsecase getRecommendedDestinationUsecase;
  final GetPopularDestinationUsecase getPopularDestinationUsecase;

  DestinationController({
    required this.getRecommendedDestinationUsecase,
    required this.getPopularDestinationUsecase,
  });

  List<DestinationEntity> recommended = [];
  List<DestinationEntity> popular = [];
  bool isLoading = false;
  bool isLoading2 = false;

  getPopular() {
    isLoading2 = true;
    notifyListeners();

    final dataStream = getPopularDestinationUsecase.call();
    dataStream.listen(
      (destinations) {
        popular = destinations;
        isLoading2 = false;
        notifyListeners();
        log('Popular: ${popular.length}');
      },
    ).onError((error) {
      log('Error from fetching all destinations: $error');
      isLoading2 = false;
      notifyListeners();
    });
  }

  getRecommended() {
    isLoading = true;
    notifyListeners();

    final dataStream = getRecommendedDestinationUsecase.call();
    dataStream.listen(
      (destination) {
        log('Listening to recommended stream');
        recommended = destination;
        isLoading = false;
        notifyListeners();
        log('Recommended ${recommended.length}');
      },
    ).onError((error) {
      isLoading = false;
      notifyListeners();
    });
  }
}
