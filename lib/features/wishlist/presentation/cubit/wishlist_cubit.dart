import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/wishlist/data/wishlist_repository.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistInitial());

  final WishlistRepository _repository = WishlistRepository();
  final List<WishlistItemModel> _items = [];

  String get _userId => FirebaseAuth.instance.currentUser?.uid ?? 'guest';
  List<WishlistItemModel> get items => List.unmodifiable(_items);

  Future<void> loadWishlist() async {
    emit(const WishlistLoading());
    try {
      final restored = await _repository.restoreWishlist(_userId);
      _items.clear();
      _items.addAll(restored);
      emit(WishlistLoaded(List.from(_items)));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  void addToWishlist(WishlistItemModel item) {
    if (_items.any((i) => i.id == item.id)) return;
    _items.add(item);
    emit(WishlistLoaded(List.from(_items)));
    _persist();
  }

  void removeFromWishlist(String id) {
    _items.removeWhere((i) => i.id == id);
    emit(WishlistLoaded(List.from(_items)));
    _persist();
  }

  void toggleFavorite(WishlistItemModel item) {
    final idx = _items.indexWhere((i) => i.id == item.id);
    if (idx >= 0) { _items.removeAt(idx); } else { _items.add(item); }
    emit(WishlistLoaded(List.from(_items)));
    _persist();
  }

  bool isInWishlist(String id) => _items.any((i) => i.id == id);

  Future<void> _persist() async {
    try { await _repository.saveWishlist(_userId, _items); } catch (_) {}
  }
}
