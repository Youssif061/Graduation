import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/product_model.dart';

class AddProductRepository {
  AddProductRepository();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseStorage _storage = FirebaseStorage.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection("products");

  String get providerId {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not authenticated.");
    }

    return user.uid;
  }

  //==========================================
  // Upload Images
  //==========================================

  Future<List<String>> uploadImages(List<File> images) async {
    final List<String> urls = [];

    for (final image in images) {
      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}";

      final ref = _storage
          .ref()
          .child("products")
          .child(providerId)
          .child(fileName);

      final uploadTask = await ref.putFile(image);

      if (uploadTask.state == TaskState.success) {
        final url = await ref.getDownloadURL();

        urls.add(url);
      }
    }

    return urls;
  }

  //==========================================
  // Add Product
  //==========================================

  Future<void> addProduct(ProductModel product) async {
    await _products.add(product.toJson());
  }

  //==========================================
  // Update Product
  //==========================================

  Future<void> updateProduct(ProductModel product) async {
    await _products.doc(product.id).update(product.toJson());
  }
}
