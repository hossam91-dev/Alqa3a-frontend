import '../../../../core/error/app_exception.dart';
import '../../../../core/utils/result.dart';
import '../entities/booking_entity.dart';

abstract class BookingsRepository {
  Future<Result<List<BookingEntity>, AppException>> getMyBookings();

  Future<Result<BookingEntity, AppException>> getBookingById(String id);

  Future<Result<BookingEntity, AppException>> createBooking({
    required String hallId,
    required String eventDate,
    required int guestsCount,
    String? notes,
  });

  Future<Result<BookingEntity, AppException>> cancelBooking(String id);
}