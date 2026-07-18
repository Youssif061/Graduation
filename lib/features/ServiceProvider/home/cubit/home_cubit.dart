import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/home_model.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._repository,
  ) : super(
          const HomeInitial(),
        );

  final HomeRepository _repository;

  HomeStatsModel? _stats;

  HomeStatsModel? get stats => _stats;

  //----------------------------------------------------------
  // Load Home Data
  //----------------------------------------------------------

  Future<void> loadHomeData() async {
    try {
      emit(
        const HomeLoading(),
      );

      final result =
          await _repository.getHomeStats();

      _stats = result;

      emit(
        HomeLoaded(
          result,
        ),
      );
    } catch (e) {
      emit(
        HomeFailure(
          e.toString(),
        ),
      );
    }
  }

  //----------------------------------------------------------
  // Refresh
  //----------------------------------------------------------

  Future<void> refresh() async {
    await loadHomeData();
  }

  //----------------------------------------------------------
  // Update Rating
  //----------------------------------------------------------

  Future<void> updateRating({
    required double rating,
    required int reviews,
  }) async {
    try {
      await _repository.updateRating(
        rating: rating,
        reviews: reviews,
      );

      if (_stats != null) {
        _stats = _stats!.copyWith(
          rating: rating,
          reviews: reviews,
        );

        emit(
          HomeLoaded(
            _stats!,
          ),
        );
      }
    } catch (e) {
      emit(
        HomeFailure(
          e.toString(),
        ),
      );
    }
  }

  //----------------------------------------------------------
  // Refresh Statistics
  //----------------------------------------------------------

  Future<void> refreshStatistics() async {
    await loadHomeData();
  }

  //----------------------------------------------------------
  // Update Total Jobs
  //----------------------------------------------------------

  Future<void> updateTotalJobs() async {
    try {
      final result =
          await _repository.getHomeStats();

      _stats = result;

      emit(
        HomeLoaded(
          result,
        ),
      );
    } catch (e) {
      emit(
        HomeFailure(
          e.toString(),
        ),
      );
    }
  }

  //----------------------------------------------------------
  // Clear
  //----------------------------------------------------------

  void clear() {
    _stats = null;

    emit(
      const HomeInitial(),
    );
  }
}