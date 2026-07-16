import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/repository/inventory_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InventoryRepositoryImpl
    implements InventoryRepository {
  InventoryRepositoryImpl();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>>
      get _products =>
          _firestore.collection("products");

  String get _providerId {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not authenticated.");
    }

    return user.uid;
  }

  //==========================================
  // Load Inventory
  //==========================================

  @override
  Future<List<ProductModel>> loadInventory() async {
    final snapshot = await _products
        .where(
          "providerId",
          isEqualTo: _providerId,
        )
        .orderBy(
          "createdAt",
          descending: true,
        )
        .get();

    return snapshot.docs
        .map(
          (doc) => ProductModel.fromJson(
            doc.data(),
            doc.id,
          ),
        )
        .toList();
  }

  //==========================================
  // Delete Product
  //==========================================

  @override
  Future<void> deleteProduct(
    String productId,
  ) async {
    await _products
        .doc(productId)
        .delete();
  }
}