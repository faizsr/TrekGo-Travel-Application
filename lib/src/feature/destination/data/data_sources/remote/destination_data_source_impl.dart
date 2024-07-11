import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trekgo_project/src/feature/destination/data/data_sources/remote/destination_data_source.dart';
import 'package:trekgo_project/src/feature/destination/data/mappers/destination_mapper.dart';
import 'package:trekgo_project/src/feature/destination/data/models/destination_model.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';

class DestinationDataSourceImpl implements DestinationDataSource {
  final FirebaseFirestore fireStore;

  DestinationDataSourceImpl({required this.fireStore});

  FirebaseFirestore get instance => fireStore;

  @override
  Stream<List<DestinationEntity>> fetchPopular() {
    try {
      final data = instance
          .collection('destination')
          .where('place_category', isEqualTo: 'Popular')
          .snapshots()
          .map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              final data = doc.data();
              final destinationModel = DestinationModel.fromJson(data);
              return DestinationMapper.mapToEntity(destinationModel);
            },
          ).toList();
        },
      );
      return data;
    } catch (e) {
      log('On Error: $e');
      return const Stream.empty();
    }
  }

  @override
  Stream<List<DestinationEntity>> fetchRecommended() {
    try {
      final data = instance
          .collection('destination')
          .where('place_category', isEqualTo: 'Recommended')
          .snapshots()
          .map(
        (snapshot) {
          return snapshot.docs.map(
            (doc) {
              final data = doc.data();
              final destinationModel = DestinationModel.fromJson(data);
              return DestinationMapper.mapToEntity(destinationModel);
            },
          ).toList();
        },
      );
      return data;
    } catch (e) {
      log('On Error: $e');
      return const Stream.empty();
    }
  }
}
