import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../entities/hall_entity.dart';

abstract class HallsRepository {
  Future<Result<List<HallEntity>, AppException>> getHalls({
    String? region,
    double? minPrice,
    double? maxPrice,
    int? capacity,
  });

  Future<Result<HallEntity, AppException>> getHallById(String id);
  Future<Result<List<HallEntity>, AppException>> getPopularHalls();
  Future<Result<List<HallEntity>, AppException>> getHallsWithDiscounts();
}