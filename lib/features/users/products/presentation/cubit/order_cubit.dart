import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/users/products/data/order_repository.dart';
import 'package:expertisemarket/features/users/products/models/order_model.dart';
import 'package:expertisemarket/features/users/products/models/product_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderInitial());

  final OrderRepository _repository = OrderRepository();
  bool _isSubmitting = false;

  String get _userId => FirebaseAuth.instance.currentUser?.uid ?? 'guest';

  Future<void> placeOrder({
    required List<CartItemModel> items,
    required String address,
    required String paymentMethod,
  }) async {
    if (_isSubmitting) return;
    _isSubmitting = true;
    emit(const OrderLoading());
    try {
      final subtotal = items.fold<double>(0, (s, i) => s + i.price * i.quantity);
      final taxes = subtotal * 0.08;
      final total = subtotal + taxes;
      final order = OrderModel(
        id: '', userId: _userId, items: items,
        subtotal: subtotal, taxes: taxes, total: total,
        address: address, paymentMethod: paymentMethod,
        status: 'Pending', createdAt: DateTime.now(),
      );
      final savedOrder = await _repository.createOrder(order);
      emit(OrderSuccess(savedOrder));
    } catch (e) {
      emit(OrderError(e.toString()));
    } finally {
      _isSubmitting = false;
    }
  }

  void reset() { emit(const OrderInitial()); }
}
