import 'package:equatable/equatable.dart';

enum OrderStage { orderPlaced, processing, outForDelivery, delivered }

enum OrderStepVisualState { completed, current, upcoming }

class TrackOrderStepModel extends Equatable {
  const TrackOrderStepModel({
    required this.stage,
    required this.title,
    required this.description,
    this.timestamp,
  });

  final OrderStage stage;
  final String title;
  final String description;
  final DateTime? timestamp;

  @override
  List<Object?> get props => [stage, title, description, timestamp];
}
