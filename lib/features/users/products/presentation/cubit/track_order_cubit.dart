import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/users/products/data/order_repository.dart';
import 'package:expertisemarket/features/users/products/models/order_model.dart';

part 'track_order_state.dart';

class TrackOrderCubit extends Cubit<TrackOrderState> {
  TrackOrderCubit() : super(const TrackOrderInitial());

  final OrderRepository _repository = OrderRepository();
  StreamSubscription? _subscription;

  void trackOrder(String orderId) {
    emit(const TrackOrderLoading());
    _subscription?.cancel();
    _subscription = _repository.trackOrder(orderId).listen(
      (order) {
        if (order != null) { emit(TrackOrderLoaded(order)); }
        else { emit(const TrackOrderError('Order not found')); }
      },
      onError: (error) { emit(TrackOrderError(error.toString())); },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
