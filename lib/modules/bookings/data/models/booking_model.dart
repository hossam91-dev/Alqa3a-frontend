import '../../domain/entities/booking_entity.dart';
import '../../../halls/data/models/hall_model.dart';

class BookingModel {
  final String id;
  final HallModel hall;
  final DateTime eventDate;
  final int guestsCount;
  final double totalPrice;
  final BookingStatus status;
  final String? notes;
  final DateTime createdAt;

  const BookingModel({
    required this.id,
    required this.hall,
    required this.eventDate,
    required this.guestsCount,
    required this.totalPrice,
    required this.status,
    this.notes,
    required this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      hall: HallModel.fromJson(json['hall']),
      eventDate: DateTime.parse(json['eventDate']),
      guestsCount: json['guestsCount'],
      totalPrice: double.parse(json['totalPrice'].toString()),
      status: BookingStatus.fromString(json['status']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  BookingEntity toEntity() {
    return BookingEntity(
      id: id,
      hall: hall.toEntity(),
      eventDate: eventDate,
      guestsCount: guestsCount,
      totalPrice: totalPrice,
      status: status,
      notes: notes,
      createdAt: createdAt,
    );
  }
}