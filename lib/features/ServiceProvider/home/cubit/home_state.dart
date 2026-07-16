import 'package:equatable/equatable.dart';
import 'package:expertisemarket/features/ServiceProvider/home/model/home_model.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final HomeStatsModel stats;

  const HomeLoaded(this.stats);

  @override
  List<Object?> get props => [stats];
}

final class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}