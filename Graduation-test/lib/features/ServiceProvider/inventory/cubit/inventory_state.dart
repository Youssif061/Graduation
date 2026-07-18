part of 'inventory_cubit.dart';

sealed class InventoryState {
  const InventoryState();
}

//==================================================
// Initial
//==================================================

final class InventoryInitial extends InventoryState {
  const InventoryInitial();
}

//==================================================
// Loading
//==================================================

final class InventoryLoading extends InventoryState {
  const InventoryLoading();
}

//==================================================
// Deleting
//==================================================

final class InventoryDeleting extends InventoryState {
  const InventoryDeleting();
}

//==================================================
// Loaded
//==================================================

final class InventoryLoaded extends InventoryState {
  final List<ProductModel> products;

  const InventoryLoaded({
    required this.products,
  });

  int get totalProducts => products.length;

  int get activeProducts =>
      products.where((e) => e.stock > 0).length;

  int get lowStockProducts =>
      products.where(
        (e) => e.stock > 0 && e.stock <= 5,
      ).length;

  int get outOfStockProducts =>
      products.where(
        (e) => e.stock == 0,
      ).length;

  double get totalInventoryValue {
    double total = 0;

    for (final product in products) {
      total += product.price * product.stock;
    }

    return total;
  }
}

//==================================================
// Failure
//==================================================

final class InventoryFailure extends InventoryState {
  final String message;

  const InventoryFailure(
    this.message,
  );
}