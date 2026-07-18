import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/repository/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  InventoryRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection("products");

  //----------------------------------------------------------
  // Current Worker
  //----------------------------------------------------------

  String get providerId => _auth.currentUser!.uid;

  //----------------------------------------------------------
  // Load Inventory
  //----------------------------------------------------------

  @override
  Future<List<ProductModel>> loadInventory() async {
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

    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(
        doc.data(),
        doc.id,
      );
    }).toList();
  }

  //----------------------------------------------------------
  // Delete Product
  //----------------------------------------------------------

  @override
  Future<void> deleteProduct(
    String productId,
  ) async {
    await _products.doc(productId).delete();
  }

  //----------------------------------------------------------
  // Refresh
  //----------------------------------------------------------

  @override
  Future<List<ProductModel>> refreshInventory() {
    return loadInventory();
  }
}