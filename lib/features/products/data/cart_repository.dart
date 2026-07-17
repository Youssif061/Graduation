import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveCart(String userId, List<CartItemModel> items) async {
    final listJson = items.map((item) => item.toJson()).toList();
    await _firestore.collection('cart').doc(userId).set({
      'items': listJson,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<CartItemModel>> restoreCart(String userId) async {
    final doc = await _firestore.collection('cart').doc(userId).get();
    if (!doc.exists || doc.data() == null) return [];
    
    final list = doc.data()!['items'] as List<dynamic>?;
    if (list == null) return [];

    return list
        .map((itemJson) => CartItemModel.fromJson(Map<String, dynamic>.from(itemJson)))
        .toList();
  }

  Future<void> clearCart(String userId) async {
    await _firestore.collection('cart').doc(userId).delete();
  }
}
