import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/users/products/data/product_repository.dart';
import 'package:expertisemarket/features/users/products/models/product_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductInitial()) {
    _loadProducts();
  }

  final ProductRepository _repository = ProductRepository();
  StreamSubscription? _subscription;
  List<ProductModel> _allProducts = [];

  void _loadProducts() {
    emit(const ProductLoading());
    _subscription = _repository.getProductsStream().listen(
      (products) {
        _allProducts = products;
        emit(ProductLoaded(products));
      },
      onError: (error) {
        emit(ProductError(error.toString()));
      },
    );
  }

  void searchProducts(String query) {
    if (query.trim().isEmpty) {
      emit(ProductLoaded(_allProducts));
      return;
    }
    final filtered = _allProducts.where((p) {
      return p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.category.toLowerCase().contains(query.toLowerCase()) ||
          p.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
    emit(ProductLoaded(filtered));
  }

  void filterByCategory(String category) {
    if (category == 'All Gear' || category.isEmpty) {
      emit(ProductLoaded(_allProducts));
      return;
    }
    final filtered = _allProducts.where((p) => p.category == category).toList();
    emit(ProductLoaded(filtered));
  }

  List<ProductModel> get allProducts => _allProducts;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
