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

  //--------------------------------------------------
  // Current Provider
  //--------------------------------------------------

  String? get currentProviderId =>
      _auth.currentUser?.uid;

  //--------------------------------------------------
  // Load Inventory
  //--------------------------------------------------

  @override
  Future<List<ProductModel>> loadInventory() async {
    try {
      final providerId =
          currentProviderId;

      // المستخدم لم يسجل دخول بعد
      if (providerId == null) {
        return [];
      }

      final snapshot = await _products
          .where(
            "providerId",
            isEqualTo: providerId,
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
    } on FirebaseException {
      return [];
    } catch (_) {
      return [];
    }
  }

  //--------------------------------------------------
  // Delete Product
  //--------------------------------------------------

  @override
  Future<void> deleteProduct(
    String productId,
  ) async {
    try {
      final providerId =
          currentProviderId;

      if (providerId == null) {
        return;
      }

      await _products
          .doc(productId)
          .delete();
    } catch (_) {
      // Ignore
    }
  }
}