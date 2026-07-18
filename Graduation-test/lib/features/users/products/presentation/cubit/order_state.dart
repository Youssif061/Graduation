part of 'order_cubit.dart';

sealed class OrderState {
  const OrderState();
}

final class OrderInitial extends OrderState {
  const OrderInitial();
}

final class OrderLoading extends OrderState {
  const OrderLoading();
}

final class OrderSuccess extends OrderState {
  final OrderModel order;
  const OrderSuccess(this.order);
}

final class OrderError extends OrderState {
  final String message;
  const OrderError(this.message);
}
