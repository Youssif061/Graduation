import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/track_order_model.dart';
import '../models/track_order_step_model.dart';
import 'track_order_state.dart';

class TrackOrderCubit extends Cubit<TrackOrderState> {
  TrackOrderCubit({required TrackOrderModel order})
    : super(TrackOrderState(order: order));

  void updateStage(OrderStage stage) {
    if (stage == state.order.currentStage) {
      return;
    }

    emit(state.copyWith(order: state.order.copyWith(currentStage: stage)));
  }
}
