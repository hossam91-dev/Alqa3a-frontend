import '../../domain/entities/saved_hall_entity.dart';

sealed class SavedHallsState {}

class SavedHallsInitial extends SavedHallsState {}

class SavedHallsLoading extends SavedHallsState {}

class SavedHallsLoaded extends SavedHallsState {
  final Set<String> savedHallIds;
  final List<SavedHallEntity> savedHalls;
  SavedHallsLoaded(this.savedHallIds, this.savedHalls);
}

class SavedHallsError extends SavedHallsState {
  final String message;
  SavedHallsError(this.message);
}