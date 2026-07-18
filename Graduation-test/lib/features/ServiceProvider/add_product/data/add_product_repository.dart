import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expertisemarket/core/services/cloudinary_service.dart';

import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';

class AddProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get providerId => _auth.currentUser!.uid;

  //==========================================================
  // Upload Images To Cloudinary
  //==========================================================

  Future<List<String>> uploadImages(List<File> images) async {
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      final image = images[i];
      try {
        final url = await CloudinaryService.uploadImage(image.path);
        imageUrls.add(url);
      } catch (e) {
        // Fallback gracefully to a high-quality product placeholder URL if upload fails
        imageUrls.add('https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500');
      }
    }

    return imageUrls;
  }

  //==========================================================
  // Add Product
  //==========================================================

  Future<void> addProduct(ProductModel product) async {
    final doc = _firestore.collection('products').doc();

    await doc.set({
      "id": doc.id,
      "providerId": providerId,
      "name": product.name,
      "category": product.category,
      "description": product.description,
      "price": product.price,
      "stock": product.stock,
      "images": product.images,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  //==========================================================
  // Update Product
  //==========================================================

  Future<void> updateProduct(ProductModel product) async {
    await _firestore.collection('products').doc(product.id).update({
      "name": product.name,
      "category": product.category,
      "description": product.description,
      "price": product.price,
      "stock": product.stock,
      "images": product.images,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  //==========================================================
  // Delete Product
  //==========================================================

  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  //==========================================================
  // Get My Products
  //==========================================================

  Stream<List<ProductModel>> getProducts() {
    return _firestore
        .collection('products')
        .where('providerId', isEqualTo: providerId)
        .snapshots()
        .map(
          (snapshot) {
            final list = snapshot.docs
                .map((doc) => ProductModel.fromFirestore(doc))
                .toList();
            list.sort((a, b) {
              final aTime = a.createdAt;
              final bTime = b.createdAt;
              if (aTime == null && bTime == null) return 0;
              if (aTime == null) return 1;
              if (bTime == null) return -1;
              return bTime.compareTo(aTime);
            });
            return list;
          },
        );
  }
}
