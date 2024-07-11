import 'package:trekgo_project/src/feature/destination/data/data_sources/remote/destination_data_source.dart';
import 'package:trekgo_project/src/feature/destination/domain/entities/destination_entity.dart';
import 'package:trekgo_project/src/feature/destination/domain/repositories/destination_repository.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final DestinationDataSource destinationDataSource;

  DestinationRepositoryImpl({required this.destinationDataSource});

  @override
  Stream<List<DestinationEntity>> getPopular() =>
      destinationDataSource.fetchPopular();

  @override
  Stream<List<DestinationEntity>> getRecommended() =>
      destinationDataSource.fetchRecommended();
}
