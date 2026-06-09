import 'package:alqa3a/modules/smart_match/domain/repositories/smart_match_repository.dart';
import 'package:alqa3a/modules/smart_match/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';

class SmartMatchCubit extends Cubit<SmartMatchState> {
  final SmartMatchRepository _smartMatchRepository;

  SmartMatchCubit({required SmartMatchRepository smartMatchRepository})
      : _smartMatchRepository = smartMatchRepository,
        super(SmartMatchInitial());

  Future<void> match({
    required String region,
    required String eventDate,
    required int guestsCount,
    required double budgetMin,
    required double budgetMax,
  }) async {
    emit(SmartMatchLoading());
    final result = await _smartMatchRepository.match(
      region: region,
      eventDate: eventDate,
      guestsCount: guestsCount,
      budgetMin: budgetMin,
      budgetMax: budgetMax,
    );
    switch (result) {
      case Success(data: var results):
        if (results.isEmpty) {
          emit(SmartMatchEmpty());
        } else {
          emit(SmartMatchLoaded(results));
        }
      case Failure(error: var error):
        emit(SmartMatchError(error.message));
    }
  }

  void reset() {
    emit(SmartMatchInitial());
  }
}