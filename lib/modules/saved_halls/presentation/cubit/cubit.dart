import 'package:alqa3a/core/interfaces/hall_saveable.dart';
import 'package:alqa3a/modules/saved_halls/domain/repositories/saved_halls_repository.dart';
import 'package:alqa3a/modules/saved_halls/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/saved_hall_entity.dart';

class SavedHallsCubit extends Cubit<SavedHallsState> {
  final SavedHallsRepository _savedHallsRepository;



  SavedHallsCubit({required final SavedHallsRepository savedHallsRepository})
    : _savedHallsRepository = savedHallsRepository,
      super(SavedHallsInitial());

  Future<void> getSavedHalls() async {
    emit(SavedHallsLoading());
    final result = await _savedHallsRepository.getMySavedHalls();
    switch (result) {
      case Success(data: var savedHalls):
        emit(
          SavedHallsLoaded(
            savedHalls.map((e) => e.hall.id).toSet(),
            savedHalls,
          ),
        );
      case Failure(error: var error):
        emit(SavedHallsError(error.message));
    }
  }

  Future<void> toggleSave(String hallId, [HallSaveable? hall]) async {
    if (state is! SavedHallsLoaded) return;
    final currentState = state as SavedHallsLoaded;
    final isSaved = currentState.savedHallIds.contains(hallId);

    final newIds = Set<String>.from(currentState.savedHallIds);
    final newHalls = List<SavedHallEntity>.from(currentState.savedHalls);

    if (isSaved) {
      newIds.remove(hallId);
      newHalls.removeWhere((e) => e.hall.id == hallId);
    } else {
      newIds.add(hallId);
      if (hall != null) {
        newHalls.add(
          SavedHallEntity(id: hallId, hall: hall, savedAt: DateTime.now()),
        );
      }
    }

    emit(SavedHallsLoaded(newIds, newHalls));

    final result = isSaved
        ? await _savedHallsRepository.unsaveHall(hallId)
        : await _savedHallsRepository.saveHall(hallId);

    if (result is Failure) {
      emit(currentState);
    }
  }

  bool isSaved(String hallId) {
    if (state is SavedHallsLoaded) {
      return (state as SavedHallsLoaded).savedHallIds.contains(hallId);
    }
    return false;
  }
}
