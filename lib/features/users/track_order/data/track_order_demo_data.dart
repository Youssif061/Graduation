import '../models/track_order_model.dart';
import '../models/track_order_step_model.dart';

const String _demoOrderId = '#EM-82941-XQ';

final TrackOrderModel demoTrackOrder = TrackOrderModel(
  orderId: _demoOrderId,
  estimatedDelivery: DateTime.now().add(const Duration(hours: 4)),
  currentStage: OrderStage.outForDelivery,
  progressSteps: [
    TrackOrderStepModel(
      stage: OrderStage.orderPlaced,
      title: 'Order Placed',
      description: 'We received your order',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    TrackOrderStepModel(
      stage: OrderStage.processing,
      title: 'Processing',
      description: 'Preparing your package',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    TrackOrderStepModel(
      stage: OrderStage.outForDelivery,
      title: 'Out for Delivery',
      description: 'Courier is en route',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    TrackOrderStepModel(
      stage: OrderStage.delivered,
      title: 'Delivered',
      description: 'Order delivered to recipient',
      timestamp: null,
    ),
  ],
  serviceLocationName: 'Home',
  serviceAddressLine1: '123 Market Street',
  serviceAddressLine2: 'Apt 4B',
  deliveryInstructions: 'Leave at the doorstep if not home',
  serviceName: 'Market Analysis',
  packageName: 'Full Market Report',
  itemImagePath: null,
  itemPrice: 129.99,
  taxes: 5.20,
  totalPaid: 135.19,
  currencySymbol: '\$',
  isVerifiedExpert: true,
);
