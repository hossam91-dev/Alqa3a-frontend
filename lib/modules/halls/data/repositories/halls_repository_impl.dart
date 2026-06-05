import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/hall_entity.dart';
import '../../domain/repositories/halls_repository.dart';
import '../datasources/halls_remote_datasource.dart';

class HallsRepositoryImpl implements HallsRepository {
  final HallsRemoteDataSource _remoteDataSource;

  HallsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<HallEntity>, AppException>> getHalls({
    String? region,
    double? minPrice,
    double? maxPrice,
    int? capacity,
  }) async {
    final result = await _remoteDataSource.getHalls(
      region: region,
      minPrice: minPrice,
      maxPrice: maxPrice,
      capacity: capacity,
    );
    switch (result) {
      case Success(data: var data):
        return Success(data.map((e) => e.toEntity()).toList());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<HallEntity, AppException>> getHallById(String id) async {
    final result = await _remoteDataSource.getHallById(id);
    switch (result) {
      case Success(data: var data):
        return Success(data.toEntity());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<List<HallEntity>, AppException>> getPopularHalls() async {
    final result = await _remoteDataSource.getPopularHalls();
    switch (result) {
      case Success(data: var data):
        return Success(data.map((e) => e.toEntity()).toList());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<List<HallEntity>, AppException>> getHallsWithDiscounts() async {
    final result = await _remoteDataSource.getHallsWithDiscounts();
    switch (result) {
      case Success(data: var data):
        return Success(data.map((e) => e.toEntity()).toList());
      case Failure(error: var error):
        return Failure(error);
    }
  }
}