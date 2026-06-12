import '../../../halls/data/models/hall_model.dart';
import '../../domain/entities/saved_hall_entity.dart';

class SavedHallModel {
  final String id;
  final HallModel hall;
  final DateTime savedAt;

  const SavedHallModel({
    required this.id,
    required this.hall,
    required this.savedAt,
  });

  factory SavedHallModel.fromJson(Map<String, dynamic> json) {
    return SavedHallModel(
      id: json['id'],
      hall: HallModel.fromJson(json['hall']),
      savedAt: DateTime.parse(json['savedAt']),
    );
  }

  SavedHallEntity toEntity() {
    return SavedHallEntity(
      id: id,
      hall: hall.toEntity(),
      savedAt: savedAt,
    );
  }
}