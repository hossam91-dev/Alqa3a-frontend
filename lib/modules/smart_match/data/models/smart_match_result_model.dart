

import '../../domain/entities/smart_match_result_entity.dart';

class SmartMatchResultModel {
  final String id;
  final String name;
  final String region;
  final String address;
  final int capacity;
  final double pricePerEvent;
  final double avgRating;
  final double score;
  final String? coverImage;

  const SmartMatchResultModel({
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

  factory SmartMatchResultModel.fromJson(Map<String, dynamic> json) {
    return SmartMatchResultModel(
      id: json['id'],
      name: json['name'],
      region: json['region'],
      address: json['address'],
      capacity: json['capacity'],
      pricePerEvent: double.parse(json['pricePerEvent'].toString()),
      avgRating: double.parse(json['avgRating'].toString()),
      score: double.parse(json['score'].toString()),
      coverImage: json['coverImage'],
    );
  }

  SmartMatchResultEntity toEntity() {
    return SmartMatchResultEntity(
      id: id,
      name: name,
      region: region,
      address: address,
      capacity: capacity,
      pricePerEvent: pricePerEvent,
      avgRating: avgRating,
      score: score,
      coverImageUrl: coverImage,
    );
  }
}