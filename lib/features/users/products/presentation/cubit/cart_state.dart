part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {
  const CartInitial();
}

final class CartLoading extends CartState {
  const CartLoading();
}

final class CartLoaded extends CartState {
  final List<CartItemModel> items;
  final double subtotal;
  final double tax;
  final double total;
  const CartLoaded({required this.items, required this.subtotal, required this.tax, required this.total});
}

final class CartError extends CartState {
  final String message;
  const CartError(this.message);
}
