part of 'inventory_cubit.dart';

sealed class InventoryState {
  const InventoryState();
}

class InventoryInitial extends InventoryState {
  const InventoryInitial();
}

class InventoryLoading extends InventoryState {
  const InventoryLoading();
}

class InventoryDeleting extends InventoryState {
  const InventoryDeleting();
}

class InventoryLoaded extends InventoryState {
  final List<ProductModel> products;

  const InventoryLoaded(
    this.products,
  );
}

class InventoryFailure extends InventoryState {
  final String message;

  const InventoryFailure(
    this.message,
  );
}