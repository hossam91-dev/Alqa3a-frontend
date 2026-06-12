import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/saved_hall_entity.dart';
import '../../domain/repositories/saved_halls_repository.dart';
import '../datasources/saved_halls_remote_datasource.dart';

class SavedHallsRepositoryImpl implements SavedHallsRepository {
  final SavedHallsRemoteDataSource _remoteDataSource;

  SavedHallsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<SavedHallEntity>, AppException>> getMySavedHalls() async {
    final result = await _remoteDataSource.getMySavedHalls();
    switch (result) {
      case Success(data: var data):
        return Success(data.map((e) => e.toEntity()).toList());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<void, AppException>> saveHall(String hallId) {
    return _remoteDataSource.saveHall(hallId);
  }

  @override
  Future<Result<void, AppException>> unsaveHall(String hallId) {
    return _remoteDataSource.unsaveHall(hallId);
  }
}