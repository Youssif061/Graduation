import 'package:equatable/equatable.dart';
import 'package:expertisemarket/features/ServiceProvider/home/model/home_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final HomeStatsModel stats;

  const HomeLoaded(this.stats);

  @override
  List<Object?> get props => [stats];
}

class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object?> get props => [message];
}