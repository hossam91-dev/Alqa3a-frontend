import '../../domain/entities/hall_entity.dart';

sealed class HallsState {}

class HallsInitial extends HallsState {}

class HomeLoading extends HallsState {}

class HomeLoaded extends HallsState {
  final List<HallEntity> popularHalls;
  final List<HallEntity> hallsWithDiscounts;

  HomeLoaded({
    required this.popularHalls,
    required this.hallsWithDiscounts,
  });
}

class HomeError extends HallsState {
  final String message;
  HomeError(this.message);
}

class HallsLoading extends HallsState {}

class HallsLoaded extends HallsState {
  final List<HallEntity> halls;
  HallsLoaded(this.halls);
}

class HallsError extends HallsState {
  final String message;
  HallsError(this.message);
}

class HallDetailsLoading extends HallsState {}

class HallDetailsLoaded extends HallsState {
  final HallEntity hall;
  HallDetailsLoaded(this.hall);
}

class HallDetailsError extends HallsState {
  final String message;
  HallDetailsError(this.message);
}