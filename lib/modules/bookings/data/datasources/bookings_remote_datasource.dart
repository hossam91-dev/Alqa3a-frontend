import 'package:alqa3a/core/constants/api_constants.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../models/booking_model.dart';

class BookingsRemoteDataSource {
  final ApiClient _apiClient;

  BookingsRemoteDataSource(this._apiClient);

  Future<Result<List<BookingModel>, AppException>> getMyBookings() {
    return _apiClient.get(
      ApiConstants.userBookingsEndpoint,
      fromJson: (data) =>
          (data as List).map((e) => BookingModel.fromJson(e)).toList(),
    );
  }

  Future<Result<BookingModel, AppException>> getBookingById(String id) {
    return _apiClient.get(
      '${ApiConstants.bookingsEndpoint}/$id',
      fromJson: (data) => BookingModel.fromJson(data),
    );
  }

  Future<Result<BookingModel, AppException>> createBooking({
    required String hallId,
    required String eventDate,
    required int guestsCount,
    String? notes,
  }) async {
    return _apiClient.post(
      ApiConstants.bookingsEndpoint,
      data: {
        'hallId': hallId,
        'eventDate': eventDate,
        'guestsCount': guestsCount,
        if (notes != null) 'notes': notes,
      },
      fromJson: (data) => BookingModel.fromJson(data),
    );
  }

  Future<Result<BookingModel, AppException>> cancelBooking(String id) {
    return _apiClient.patch(
      '${ApiConstants.bookingsEndpoint}/$id${ApiConstants.cancelBooking}',
      fromJson: (data) => BookingModel.fromJson(data),
    );
  }
}
