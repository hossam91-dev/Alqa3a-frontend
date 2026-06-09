import '../../domain/entities/booking_entity.dart';

sealed class BookingsState {
  final List<BookingEntity> bookings;
  BookingsState({this.bookings = const []});
}

class BookingsInitial extends BookingsState {}

class BookingsLoading extends BookingsState {}

class BookingsLoaded extends BookingsState {
  @override
  final List<BookingEntity> bookings;
  BookingsLoaded(this.bookings);
}

class BookingsError extends BookingsState {
  final String message;
  BookingsError(this.message);
}

class BookingDetailsLoading extends BookingsState {}

class BookingDetailsLoaded extends BookingsState {
  final BookingEntity booking;
  BookingDetailsLoaded(this.booking);
}

class BookingCreating extends BookingsState {}

class BookingCreated extends BookingsState {
  final BookingEntity booking;
  BookingCreated(this.booking);
}

class BookingCancelled extends BookingsState {
  BookingCancelled(List<BookingEntity> bookings) : super(bookings: bookings);
}

class BookingCancelledLoading extends BookingsState {
  final String id;
  BookingCancelledLoading(this.id, List<BookingEntity> bookings)
      : super(bookings: bookings);
}

class BookingCancelledError extends BookingsState {
  final String message;
  BookingCancelledError(this.message, List<BookingEntity> bookings)
      : super(bookings: bookings);
}

class BookingError extends BookingsState {
  final String message;
  BookingError(this.message);
}