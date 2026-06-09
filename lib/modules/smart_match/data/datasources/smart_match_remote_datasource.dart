import '../../../../core/network/api_client.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../models/smart_match_result_model.dart';

class SmartMatchRemoteDataSource {
  final ApiClient _apiClient;

  SmartMatchRemoteDataSource(this._apiClient);

  Future<Result<List<SmartMatchResultModel>, AppException>> match({
    required String region,
    required String eventDate,
    required int guestsCount,
    required double budgetMin,
    required double budgetMax,
  }) {
    return _apiClient.post(
      '/smart-match',
      data: {
        'region': region,
        'eventDate': eventDate,
        'guestsCount': guestsCount,
        'budgetMin': budgetMin,
        'budgetMax': budgetMax,
      },
      fromJson: (data) => (data as List)
          .map((e) => SmartMatchResultModel.fromJson(e))
          .toList(),
    );
  }
}