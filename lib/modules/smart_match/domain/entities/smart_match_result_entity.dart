import '../../../../core/interfaces/hall_saveable.dart';

class SmartMatchResultEntity implements HallSaveable {
  @override
  final String id;
  @override
  final String name;
  @override
  final String region;
  @override
  final String address;
  @override
  final int capacity;
  @override
  final double pricePerEvent;
  @override
  final double avgRating;
  final double score;
  @override
  final String? coverImageUrl;

  const SmartMatchResultEntity({
    required this.id,
    required this.name,
    required this.region,
    required this.address,
    required this.capacity,
    required this.pricePerEvent,
    required this.avgRating,
    required this.score,
    this.coverImageUrl,
  });
}