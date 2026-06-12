import '../../../../core/interfaces/hall_saveable.dart';

class AmenityEntity {
  final bool parking;
  final bool catering;
  final bool ac;
  final bool music;
  final bool photography;
  final bool accommodation;

  const AmenityEntity({
    required this.parking,
    required this.catering,
    required this.ac,
    required this.music,
    required this.photography,
    required this.accommodation,
  });
}

class HallImageEntity {
  final String id;
  final String url;
  final bool isCover;
  final int order;

  const HallImageEntity({
    required this.id,
    required this.url,
    required this.isCover,
    required this.order,
  });
}

class HallEntity implements HallSaveable {
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
  final bool isActive;
  final AmenityEntity amenities;
  final List<HallImageEntity> images;

  const HallEntity({
    required this.id,
    required this.name,
    required this.region,
    required this.address,
    required this.capacity,
    required this.pricePerEvent,
    required this.avgRating,
    required this.isActive,
    required this.amenities,
    required this.images,
  });

  @override
  String? get coverImageUrl {
    try {
      return images.firstWhere((img) => img.isCover).url;
    } catch (_) {
      return images.isNotEmpty ? images.first.url : null;
    }
  }
}
