import 'package:alqa3a/core/interfaces/hall_saveable.dart';


class SavedHallEntity {
  final String id;
  final HallSaveable hall;
  final DateTime savedAt;

  const SavedHallEntity({
    required this.id,
    required this.hall,
    required this.savedAt,
  });
}