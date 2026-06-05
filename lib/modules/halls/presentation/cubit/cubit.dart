import 'package:alqa3a/modules/halls/domain/repositories/halls_repository.dart';
import 'package:alqa3a/modules/halls/presentation/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/result.dart';

class HallsCubit extends Cubit<HallsState> {
  final HallsRepository _hallsRepository;
  HallsCubit({required HallsRepository hallsRepository})
    : _hallsRepository = hallsRepository,

      super(HallsInitial());


  Future<void> getHomeData() async {
    emit(HomeLoading());

    final results = await Future.wait([
      _hallsRepository.getHallsWithDiscounts(),
      _hallsRepository.getPopularHalls()
    ]);
    final discountsResult = results[0];
    final popularResult = results[1];


    if (popularResult is Failure || discountsResult is Failure) {
      final error = popularResult is Failure
          ? (popularResult as Failure).error
          : (discountsResult as Failure).error;
      emit(HomeError(error.message));
      return;
    }

    emit(HomeLoaded(
      popularHalls: (popularResult as Success).data,
      hallsWithDiscounts: (discountsResult as Success).data,
    ));
  }

  Future<void> getHalls({
    String? region,
    double? minPrice,
    double? maxPrice,
    int? capacity,
  }) async {
    emit(HallsLoading());
    final result = await _hallsRepository.getHalls(
      region: region,
      minPrice: minPrice,
      maxPrice: maxPrice,
      capacity: capacity,
    );
    switch (result) {
      case Success(data: var halls):
        emit(HallsLoaded(halls));
      case Failure(error: var error):
        emit(HallsError(error.message));
    }
  }

  Future<void> getHallById(String id) async {
    emit(HallDetailsLoading());
    final result = await _hallsRepository.getHallById(id);
    switch (result) {
      case Success(data: var hall):
        emit(HallDetailsLoaded(hall));
      case Failure(error: var error):
        emit(HallDetailsError(error.message));
    }
  }
}
