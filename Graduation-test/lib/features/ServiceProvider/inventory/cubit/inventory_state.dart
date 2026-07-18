part of 'inventory_cubit.dart';

sealed class InventoryState {
  const InventoryState();
}

//==========================================
// Initial
//==========================================

final class InventoryInitial
    extends InventoryState {
  const InventoryInitial();
}

//==========================================
// Loading
//==========================================

final class InventoryLoading
    extends InventoryState {
  const InventoryLoading();
}

//==========================================
// Deleting
//==========================================

final class InventoryDeleting
    extends InventoryState {
  const InventoryDeleting();
}

//==========================================
// Loaded
//==========================================

final class InventoryLoaded
    extends InventoryState {
  const InventoryLoaded({
    required this.products,
  });

  final List<ProductModel> products;
}

//==========================================
// Failure
//==========================================

final class InventoryFailure
    extends InventoryState {
  const InventoryFailure(
    this.message,
  );

  final String message;
}