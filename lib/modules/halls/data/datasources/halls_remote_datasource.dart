import 'package:alqa3a/core/constants/api_constants.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../models/hall_model.dart';

class HallsRemoteDataSource {
  final ApiClient _apiClient;

  HallsRemoteDataSource(this._apiClient);

  Future<Result<List<HallModel>, AppException>> getHalls({
    String? region,
    double? minPrice,
    double? maxPrice,
    int? capacity,
  }) {
    return _apiClient.get(
     ApiConstants.hallsEndpoint,
      queryParameters: {
        if (region != null) 'region': region,
        if (minPrice != null) 'minPrice': minPrice,
        if (maxPrice != null) 'maxPrice': maxPrice,
        if (capacity != null) 'capacity': capacity,
      },
      fromJson: (data) => (data as List)
          .map((e) => HallModel.fromJson(e))
          .toList(),
    );
  }

  Future<Result<HallModel, AppException>> getHallById(String id) {
    return _apiClient.get(
      '${ApiConstants.hallsEndpoint}/$id',
      fromJson: (data) => HallModel.fromJson(data),
    );
  }

  Future<Result<List<HallModel>, AppException>> getPopularHalls() {
    return _apiClient.get(
      ApiConstants.popularHallsEndpoint,
      fromJson: (data) => (data as List)
          .map((e) => HallModel.fromJson(e))
          .toList(),
    );
  }

  Future<Result<List<HallModel>, AppException>> getHallsWithDiscounts() {
    return _apiClient.get(
      ApiConstants.hallsWithDiscountsEndpoint,
      fromJson: (data) => (data as List)
          .map((e) => HallModel.fromJson(e))
          .toList(),
    );
  }
}