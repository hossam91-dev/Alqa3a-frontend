import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/bookings_repository.dart';
import '../datasources/bookings_remote_datasource.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  final BookingsRemoteDataSource _remoteDataSource;

  BookingsRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<BookingEntity>, AppException>> getMyBookings() async {
    final result = await _remoteDataSource.getMyBookings();
    switch (result) {
      case Success(data: var data):
        return Success(data.map((e) => e.toEntity()).toList());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<BookingEntity, AppException>> getBookingById(String id) async {
    final result = await _remoteDataSource.getBookingById(id);
    switch (result) {
      case Success(data: var data):
        return Success(data.toEntity());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<BookingEntity, AppException>> createBooking({
    required String hallId,
    required String eventDate,
    required int guestsCount,
    String? notes,
  }) async {
    final result = await _remoteDataSource.createBooking(
      hallId: hallId,
      eventDate: eventDate,
      guestsCount: guestsCount,
      notes: notes,
    );
    switch (result) {
      case Success(data: var data):
        return Success(data.toEntity());
      case Failure(error: var error):
        return Failure(error);
    }
  }

  @override
  Future<Result<BookingEntity, AppException>> cancelBooking(String id) async {
    final result = await _remoteDataSource.cancelBooking(id);
    switch (result) {
      case Success(data: var data):
        return Success(data.toEntity());
      case Failure(error: var error):
        return Failure(error);
    }
  }
}