import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/home_repository.dart';
import '../model/home_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeInitial());

  final HomeRepository _repository;

  HomeStatsModel? _stats;

  HomeStatsModel? get stats => _stats;

  /// ===========================
  /// Load Home Data
  /// ===========================
  Future<void> loadHomeData() async {
    try {
      emit(const HomeLoading());

      final data = await _repository.getHomeStats();

      _stats = data;

      emit(HomeLoaded(data));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  /// ===========================
  /// Refresh
  /// ===========================
  Future<void> refresh() async {
    await loadHomeData();
  }

  /// ===========================
  /// Update Rating
  /// ===========================
  Future<void> updateRating({
    required double rating,
    required int reviews,
  }) async {
    if (_stats == null) return;

    _stats = _stats!.copyWith(
      rating: rating,
      reviews: reviews,
    );

    emit(HomeLoaded(_stats!));
  }

  /// ===========================
  /// Update Total Jobs
  /// ===========================
  Future<void> updateTotalJobs(int totalJobs) async {
    if (_stats == null) return;

    _stats = _stats!.copyWith(
      totalJobs: totalJobs,
    );

    emit(HomeLoaded(_stats!));
  }
}