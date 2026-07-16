import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/products/data/cart_repository.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial());

  final CartRepository _repository = CartRepository();
  final List<CartItemModel> _items = [];

  String get _userId => FirebaseAuth.instance.currentUser?.uid ?? 'guest';

  List<CartItemModel> get items => List.unmodifiable(_items);
  double get subtotal => _items.fold(0, (s, i) => s + i.price * i.quantity);
  double get tax => subtotal * 0.05;
  double get total => subtotal + tax;

  Future<void> loadCart() async {
    emit(const CartLoading());
    try {
      final restored = await _repository.restoreCart(_userId);
      _items.clear();
      _items.addAll(restored);
      _emitLoaded();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void addItem(CartItemModel item) {
    final idx = _items.indexWhere((i) => i.id == item.id);
    if (idx >= 0) {
      _items[idx].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    _emitLoaded();
    _persist();
  }

  void removeItem(String id) {
    _items.removeWhere((i) => i.id == id);
    _emitLoaded();
    _persist();
  }

  void increaseQuantity(String id) {
    final idx = _items.indexWhere((i) => i.id == id);
    if (idx >= 0) {
      _items[idx].quantity++;
      _emitLoaded();
      _persist();
    }
  }

  void decreaseQuantity(String id) {
    final idx = _items.indexWhere((i) => i.id == id);
    if (idx >= 0) {
      if (_items[idx].quantity > 1) {
        _items[idx].quantity--;
      } else {
        _items.removeAt(idx);
      }
      _emitLoaded();
      _persist();
    }
  }

  void clearCart() {
    _items.clear();
    _emitLoaded();
    _repository.clearCart(_userId);
  }

  void _emitLoaded() {
    emit(CartLoaded(items: List.from(_items), subtotal: subtotal, tax: tax, total: total));
  }

  Future<void> _persist() async {
    try { await _repository.saveCart(_userId, _items); } catch (_) {}
  }
}
