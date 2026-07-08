import 'package:equatable/equatable.dart';

import 'track_order_step_model.dart';

class TrackOrderModel extends Equatable {
  const TrackOrderModel({
    required this.orderId,
    required this.estimatedDelivery,
    required this.currentStage,
    required this.progressSteps,
    required this.serviceLocationName,
    required this.serviceAddressLine1,
    this.serviceAddressLine2,
    this.deliveryInstructions,
    required this.serviceName,
    required this.packageName,
    this.itemImagePath,
    required this.itemPrice,
    required this.taxes,
    required this.totalPaid,
    this.currencySymbol = '\$',
    this.isVerifiedExpert = false,
  });

  final String orderId;
  final DateTime estimatedDelivery;
  final OrderStage currentStage;
  final List<TrackOrderStepModel> progressSteps;

  final String serviceLocationName;
  final String serviceAddressLine1;
  final String? serviceAddressLine2;
  final String? deliveryInstructions;

  final String serviceName;
  final String packageName;
  final String? itemImagePath;
  final double itemPrice;
  final double taxes;
  final double totalPaid;
  final String currencySymbol;
  final bool isVerifiedExpert;

  TrackOrderModel copyWith({
    String? orderId,
    DateTime? estimatedDelivery,
    OrderStage? currentStage,
    List<TrackOrderStepModel>? progressSteps,
    String? serviceLocationName,
    String? serviceAddressLine1,
    String? serviceAddressLine2,
    String? deliveryInstructions,
    String? serviceName,
    String? packageName,
    String? itemImagePath,
    double? itemPrice,
    double? taxes,
    double? totalPaid,
    String? currencySymbol,
    bool? isVerifiedExpert,
  }) {
    return TrackOrderModel(
      orderId: orderId ?? this.orderId,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      currentStage: currentStage ?? this.currentStage,
      progressSteps: progressSteps ?? this.progressSteps,
      serviceLocationName: serviceLocationName ?? this.serviceLocationName,
      serviceAddressLine1: serviceAddressLine1 ?? this.serviceAddressLine1,
      serviceAddressLine2: serviceAddressLine2 ?? this.serviceAddressLine2,
      deliveryInstructions: deliveryInstructions ?? this.deliveryInstructions,
      serviceName: serviceName ?? this.serviceName,
      packageName: packageName ?? this.packageName,
      itemImagePath: itemImagePath ?? this.itemImagePath,
      itemPrice: itemPrice ?? this.itemPrice,
      taxes: taxes ?? this.taxes,
      totalPaid: totalPaid ?? this.totalPaid,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      isVerifiedExpert: isVerifiedExpert ?? this.isVerifiedExpert,
    );
  }

  @override
  List<Object?> get props => [
    orderId,
    estimatedDelivery,
    currentStage,
    progressSteps,
    serviceLocationName,
    serviceAddressLine1,
    serviceAddressLine2,
    deliveryInstructions,
    serviceName,
    packageName,
    itemImagePath,
    itemPrice,
    taxes,
    totalPaid,
    currencySymbol,
    isVerifiedExpert,
  ];
}
