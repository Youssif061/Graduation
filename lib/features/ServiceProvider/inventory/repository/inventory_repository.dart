import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';

abstract class InventoryRepository {
  Future<List<ProductModel>> loadInventory();

  Future<void> deleteProduct(
    String productId,
  );
}