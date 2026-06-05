import '../../domain/entities/hall_entity.dart';

class AmenityModel {
  final bool parking;
  final bool catering;
  final bool ac;
  final bool music;
  final bool photography;
  final bool accommodation;

  const AmenityModel({
    required this.parking,
    required this.catering,
    required this.ac,
    required this.music,
    required this.photography,
    required this.accommodation,
  });

  factory AmenityModel.fromJson(Map<String, dynamic> json) {
    return AmenityModel(
      parking: json['parking'] ?? false,
      catering: json['catering'] ?? false,
      ac: json['ac'] ?? false,
      music: json['music'] ?? false,
      photography: json['photography'] ?? false,
      accommodation: json['accommodation'] ?? false,
    );
  }

  AmenityEntity toEntity() {
    return AmenityEntity(
      parking: parking,
      catering: catering,
      ac: ac,
      music: music,
      photography: photography,
      accommodation: accommodation,
    );
  }
}

class HallImageModel {
  final String id;
  final String url;
  final bool isCover;
  final int order;

  const HallImageModel({
    required this.id,
    required this.url,
    required this.isCover,
    required this.order,
  });

  factory HallImageModel.fromJson(Map<String, dynamic> json) {
    return HallImageModel(
      id: json['id'],
      url: json['url'],
      isCover: json['isCover'] ?? false,
      order: json['order'] ?? 0,
    );
  }

  HallImageEntity toEntity() {
    return HallImageEntity(
      id: id,
      url: url,
      isCover: isCover,
      order: order,
    );
  }
}

class HallModel {
  final String id;
  final String name;
  final String region;
  final String address;
  final int capacity;
  final double pricePerEvent;
  final double avgRating;
  final bool isActive;
  final AmenityModel amenities;
  final List<HallImageModel> images;

  const HallModel({
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

  factory HallModel.fromJson(Map<String, dynamic> json) {
    return HallModel(
      id: json['id'],
      name: json['name'],
      region: json['region'],
      address: json['address'],
      capacity: json['capacity'],
      pricePerEvent: double.parse(json['pricePerEvent'].toString()),
      avgRating: double.parse(json['avgRating'].toString()),
      isActive: json['isActive'] ?? true,
      amenities: AmenityModel.fromJson(json['amenities'] ?? {}),
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => HallImageModel.fromJson(e))
          .toList(),
    );
  }

  HallEntity toEntity() {
    return HallEntity(
      id: id,
      name: name,
      region: region,
      address: address,
      capacity: capacity,
      pricePerEvent: pricePerEvent,
      avgRating: avgRating,
      isActive: isActive,
      amenities: amenities.toEntity(),
      images: images.map((e) => e.toEntity()).toList(),
    );
  }
}