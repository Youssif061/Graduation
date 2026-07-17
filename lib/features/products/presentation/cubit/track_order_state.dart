part of 'track_order_cubit.dart';

sealed class TrackOrderState {
  const TrackOrderState();
}

final class TrackOrderInitial extends TrackOrderState {
  const TrackOrderInitial();
}

final class TrackOrderLoading extends TrackOrderState {
  const TrackOrderLoading();
}

final class TrackOrderLoaded extends TrackOrderState {
  final OrderModel order;
  const TrackOrderLoaded(this.order);
}

final class TrackOrderError extends TrackOrderState {
  final String message;
  const TrackOrderError(this.message);
}
