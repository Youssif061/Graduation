import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';

abstract class InventoryRepository {
  /// Load all products for current worker
  Future<List<ProductModel>> loadInventory();

  /// Delete Product
  Future<void> deleteProduct(
    String productId,
  );

  /// Refresh Inventory
  Future<List<ProductModel>> refreshInventory() {
    return loadInventory();
  }
}