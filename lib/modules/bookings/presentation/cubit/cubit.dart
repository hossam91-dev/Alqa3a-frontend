import 'package:alqa3a/modules/bookings/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/bookings_repository.dart';

import '../../../../core/utils/result.dart';


class BookingsCubit extends Cubit<BookingsState> {
  final BookingsRepository _bookingsRepository;

  BookingsCubit({
    required BookingsRepository bookingsRepository,

  })  : _bookingsRepository = bookingsRepository,

        super(BookingsInitial());

  Future<void> getMyBookings() async {
    emit(BookingsLoading());
    final result = await _bookingsRepository.getMyBookings();
    switch (result) {
      case Success(data: var bookings):
        emit(BookingsLoaded(bookings));
      case Failure(error: var error):
        emit(BookingsError(error.message));
    }
  }

  Future<void> getBookingById(String id) async {
    emit(BookingDetailsLoading());
    final result = await _bookingsRepository.getBookingById(id);
    switch (result) {
      case Success(data: var booking):
        emit(BookingDetailsLoaded(booking));
      case Failure(error: var error):
        emit(BookingError(error.message));
    }
  }

  Future<void> createBooking({
    required String hallId,
    required String eventDate,
    required int guestsCount,
    String? notes,
  }) async {
    emit(BookingCreating());
    final result = await _bookingsRepository.createBooking(
      hallId: hallId,
      eventDate: eventDate,
      guestsCount: guestsCount,
      notes: notes,
    );
    switch (result) {
      case Success(data: var booking):
        emit(BookingCreated(booking));
      case Failure(error: var error):
        emit(BookingError(error.message));
    }
  }

  Future<void> cancelBooking(String id) async {
    final currentBookings = state.bookings;
    emit(BookingCancelledLoading(id, currentBookings));
    final result = await _bookingsRepository.cancelBooking(id);
    switch (result) {
      case Success():
        emit(BookingCancelled(currentBookings));
      case Failure(error: var error):
        emit(BookingCancelledError(error.message, currentBookings));
    }
  }
}