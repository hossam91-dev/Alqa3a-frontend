import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../entities/saved_hall_entity.dart';

abstract class SavedHallsRepository {
  Future<Result<List<SavedHallEntity>, AppException>> getMySavedHalls();
  Future<Result<void, AppException>> saveHall(String hallId);
  Future<Result<void, AppException>> unsaveHall(String hallId);
}