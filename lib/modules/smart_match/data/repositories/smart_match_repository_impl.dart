import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/smart_match_result_entity.dart';
import '../../domain/repositories/smart_match_repository.dart';
import '../datasources/smart_match_remote_datasource.dart';

class SmartMatchRepositoryImpl implements SmartMatchRepository {
  final SmartMatchRemoteDataSource _remoteDataSource;

  SmartMatchRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<SmartMatchResultEntity>, AppException>> match({
    required String region,
    required String eventDate,
    required int guestsCount,
    required double budgetMin,
    required double budgetMax,
  }) async {
    final result = await _remoteDataSource.match(
      region: region,
      eventDate: eventDate,
      guestsCount: guestsCount,
      budgetMin: budgetMin,
      budgetMax: budgetMax,
    );
    switch (result) {
      case Success(data: var data):
        return Success(data.map((e) => e.toEntity()).toList());
      case Failure(error: var error):
        return Failure(error);
    }
  }
}