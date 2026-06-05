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

class HallEntity {
  final String id;
  final String name;
  final String region;
  final String address;
  final int capacity;
  final double pricePerEvent;
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

  String? get coverImageUrl {
    try {
      return images.firstWhere((img) => img.isCover).url;
    } catch (_) {
      return images.isNotEmpty ? images.first.url : null;
    }
  }
}
