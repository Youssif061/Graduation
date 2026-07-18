part of 'product_cubit.dart';

sealed class ProductState {
  const ProductState();
}

final class ProductInitial extends ProductState {
  const ProductInitial();
}

final class ProductLoading extends ProductState {
  const ProductLoading();
}

final class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  const ProductLoaded(this.products);
}

final class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
}
