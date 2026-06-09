import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../entities/smart_match_result_entity.dart';

abstract class SmartMatchRepository {
  Future<Result<List<SmartMatchResultEntity>, AppException>> match({
    required String region,
    required String eventDate,
    required int guestsCount,
    required double budgetMin,
    required double budgetMax,
  });
}