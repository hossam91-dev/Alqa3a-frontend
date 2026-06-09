import '../../domain/entities/smart_match_result_entity.dart';

sealed class SmartMatchState {}

class SmartMatchInitial extends SmartMatchState {}

class SmartMatchLoading extends SmartMatchState {}

class SmartMatchLoaded extends SmartMatchState {
  final List<SmartMatchResultEntity> results;
  SmartMatchLoaded(this.results);
}

class SmartMatchEmpty extends SmartMatchState {}

class SmartMatchError extends SmartMatchState {
  final String message;
  SmartMatchError(this.message);
}
