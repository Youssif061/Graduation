import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Stream for real-time updates of all products
  Stream<List<ProductModel>> getProductsStream() {
    return _firestore
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
              .toList();
        });
  }

  // Future for one-time fetch
  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _firestore
        .collection('products')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  // Upload a list of product images to Firebase Storage
  Future<List<String>> uploadProductImages(List<File> files, String providerId) async {
    List<String> urls = [];
    for (int i = 0; i < files.length; i++) {
      final file = files[i];
      final ref = _storage.ref().child('products/$providerId/${DateTime.now().millisecondsSinceEpoch}_$i.jpg');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }

  // Save product to Firestore (inserts if ID is empty, updates otherwise)
  Future<void> saveProduct(ProductModel product) async {
    final col = _firestore.collection('products');
    if (product.id.isEmpty) {
      final docRef = col.doc();
      final toSave = product.copyWith(id: docRef.id);
      await docRef.set(toSave.toJson());
    } else {
      await col.doc(product.id).set(product.toJson());
    }
  }

  // Delete product from Firestore
  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }
}
