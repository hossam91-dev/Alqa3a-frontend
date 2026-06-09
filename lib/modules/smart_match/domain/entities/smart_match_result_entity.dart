class SmartMatchResultEntity {
  final String id;
  final String name;
  final String region;
  final String address;
  final int capacity;
  final double pricePerEvent;
  final double avgRating;
  final double score;
  final String? coverImage;

  const SmartMatchResultEntity({
    required this.id,
    required this.name,
    required this.region,
    required this.address,
    required this.capacity,
    required this.pricePerEvent,
    required this.avgRating,
    required this.score,
    this.coverImage,
  });
}