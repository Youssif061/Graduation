import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/features/users/products/models/product_model.dart';

class WishlistRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveWishlist(String userId, List<WishlistItemModel> items) async {
    final listJson = items.map((item) => item.toJson()).toList();
    await _firestore.collection('wishlist').doc(userId).set({
      'items': listJson,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<WishlistItemModel>> restoreWishlist(String userId) async {
    final doc = await _firestore.collection('wishlist').doc(userId).get();
    if (!doc.exists || doc.data() == null) return [];
    final list = doc.data()!['items'] as List<dynamic>?;
    if (list == null) return [];
    return list.map((j) => WishlistItemModel.fromJson(Map<String, dynamic>.from(j))).toList();
  }

  Future<void> clearWishlist(String userId) async {
    await _firestore.collection('wishlist').doc(userId).delete();
  }
}
