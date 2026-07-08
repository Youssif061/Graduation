import 'package:equatable/equatable.dart';

import '../models/track_order_model.dart';
import '../models/track_order_step_model.dart';

class TrackOrderState extends Equatable {
  const TrackOrderState({required this.order});

  final TrackOrderModel order;

  OrderStepVisualState visualStateFor(OrderStage stage) {
    final int stageIndex = OrderStage.values.indexOf(stage);
    final int currentStageIndex = OrderStage.values.indexOf(order.currentStage);

    if (stageIndex < currentStageIndex) {
      return OrderStepVisualState.completed;
    }

    if (stageIndex == currentStageIndex) {
      return OrderStepVisualState.current;
    }

    return OrderStepVisualState.upcoming;
  }

  bool get isDelivered => order.currentStage == OrderStage.delivered;

  TrackOrderState copyWith({TrackOrderModel? order}) {
    return TrackOrderState(order: order ?? this.order);
  }

  @override
  List<Object?> get props => [order];
}
