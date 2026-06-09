import 'package:alqa3a/core/theme/app_colors.dart';

import '../../../halls/domain/entities/hall_entity.dart';
import 'package:flutter/material.dart';
enum BookingStatus {
  pending('pending'),
  confirmed('confirmed'),
  rejected('rejected'),
  cancelled('cancelled'),
  completed('completed');

  final String value;
  const BookingStatus(this.value);

  static BookingStatus fromString(String value) {
    return BookingStatus.values.firstWhere(
          (s) => s.value == value,
      orElse: () => BookingStatus.pending,
    );
  }

  bool get isPending => this == BookingStatus.pending;
  bool get isConfirmed => this == BookingStatus.confirmed;
  bool get isRejected => this == BookingStatus.rejected;
  bool get isCancelled => this == BookingStatus.cancelled;
  bool get isCompleted => this == BookingStatus.completed;

  String get label {
    switch (this) {
      case BookingStatus.pending:   return 'معلق';
      case BookingStatus.confirmed: return 'مقبول';
      case BookingStatus.rejected:  return 'مرفوض';
      case BookingStatus.cancelled: return 'ملغي';
      case BookingStatus.completed: return 'مكتمل';
    }
  }
  Color get color{
    switch (this) {
      case BookingStatus.pending:   return AppColors.warning;
      case BookingStatus.confirmed: return AppColors.success;
      case BookingStatus.rejected:  return AppColors.error;
      case BookingStatus.cancelled: return AppColors.textLight;
      case BookingStatus.completed: return AppColors.info;
    }
  }

  Color get colorCard{
    switch (this) {
      case BookingStatus.pending:   return AppColors.warning.withAlpha(50);
      case BookingStatus.confirmed: return AppColors.success.withAlpha(50);
      case BookingStatus.rejected:  return AppColors.error.withAlpha(50);
      case BookingStatus.cancelled: return AppColors.textLight.withAlpha(50);
      case BookingStatus.completed: return AppColors.info.withAlpha(50);
    }
  }
}

class BookingEntity {
  final String id;
  final HallEntity hall;
  final DateTime eventDate;
  final int guestsCount;
  final double totalPrice;
  final BookingStatus status;
  final String? notes;
  final DateTime createdAt;

  const BookingEntity({
    required this.id,
    required this.hall,
    required this.eventDate,
    required this.guestsCount,
    required this.totalPrice,
    required this.status,
    this.notes,
    required this.createdAt,
  });
}