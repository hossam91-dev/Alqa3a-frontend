import 'package:alqa3a/core/constants/api_constants.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../models/saved_hall_model.dart';

class SavedHallsRemoteDataSource {
  final ApiClient _apiClient;

  SavedHallsRemoteDataSource(this._apiClient);

  Future<Result<List<SavedHallModel>, AppException>> getMySavedHalls() {
    return _apiClient.get(
      ApiConstants.savedHallsEndpoint,
      fromJson: (data) => (data as List)
          .map((e) => SavedHallModel.fromJson(e))
          .toList(),
    );
  }

  Future<Result<void, AppException>> saveHall(String hallId) {
    return _apiClient.post(
      '${ApiConstants.savedHallsEndpoint}/$hallId',
      fromJson: (_) {},
    );
  }

  Future<Result<void, AppException>> unsaveHall(String hallId) {
    return _apiClient.delete(
      '${ApiConstants.savedHallsEndpoint}/$hallId',
      fromJson: (_) {},
    );
  }
}