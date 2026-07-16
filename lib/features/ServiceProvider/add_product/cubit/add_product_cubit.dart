import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:expertisemarket/features/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(const AddProductInitial());

  ///================ Controllers ================///

  final nameController = TextEditingController();

  final categoryController = TextEditingController();

  final descriptionController = TextEditingController();

  final priceController = TextEditingController();

  final stockController = TextEditingController();

  ///================ Form =======================///

  final formKey = GlobalKey<FormState>();

  ///================ Images =====================///

  final ImagePicker _picker = ImagePicker();

  /// الصور الجديدة المختارة من الجهاز
  final List<File> images = [];

  /// الصور القديمة الموجودة على Firebase
  final List<String> existingImages = [];

  /// المنتج الحالي أثناء التعديل
  ProductModel? currentProduct;

  ///================ Firebase ====================///

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  String get _providerId =>
      FirebaseAuth.instance.currentUser?.uid ?? 'unknown';

  bool _isSubmitting = false;

  ///================ Load Product =================///

  void loadProduct(ProductModel product) {
    currentProduct = product;

    nameController.text = product.name;

    categoryController.text = product.category;

    descriptionController.text = product.description;

    priceController.text = product.price.toString();

    stockController.text = product.stock.toString();

    existingImages
      ..clear()
      ..addAll(product.images);

    images.clear();

    emit(ProductImagesChanged(List.from(images)));
  }

  ///================ Pick Images =================///

  Future<void> pickImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage();

      if (pickedImages.isEmpty) return;

      images.addAll(
        pickedImages.map(
          (image) => File(image.path),
        ),
      );

      emit(ProductImagesChanged(List.from(images)));
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }

  ///================ Remove New Image ===============///

  void removeImage(int index) {
    if (index < 0 || index >= images.length) return;

    images.removeAt(index);

    emit(ProductImagesChanged(List.from(images)));
  }

  ///================ Remove Existing Image =========///

  void removeExistingImage(int index) {
    if (index < 0 || index >= existingImages.length) return;

    existingImages.removeAt(index);

    emit(ProductImagesChanged(List.from(images)));
  }

  ///================ Upload Images ==================///

  Future<List<String>> _uploadImages(List<File> files) async {
    List<String> urls = [];
    for (int i = 0; i < files.length; i++) {
      final file = files[i];
      final ref = _storage.ref().child(
            'products/$_providerId/${DateTime.now().millisecondsSinceEpoch}_$i.jpg',
          );
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }

  ///================ Publish Product ===============///

  Future<void> publishProduct() async {
    try {
      if (_isSubmitting) return;
      if (!formKey.currentState!.validate()) return;

      _isSubmitting = true;
      emit(const AddProductLoading());

      // Upload Images To Firebase Storage
      List<String> imageUrls = [];
      if (images.isNotEmpty) {
        imageUrls = await _uploadImages(images);
      }

      // Save Product To Firestore
      final docRef = _firestore.collection('products').doc();

      final product = ProductModel(
        id: docRef.id,
        providerId: _providerId,
        name: nameController.text.trim(),
        category: categoryController.text.trim(),
        description: descriptionController.text.trim(),
        imageAsset: imageUrls.isNotEmpty ? imageUrls.first : '',
        price: double.tryParse(priceController.text.trim()) ?? 0.0,
        stock: int.tryParse(stockController.text.trim()) ?? 0,
        images: imageUrls,
        thumbnails: imageUrls,
        createdAt: DateTime.now(),
        status: 'active',
        inStock: (int.tryParse(stockController.text.trim()) ?? 0) > 0,
        isNew: true,
      );

      await docRef.set(product.toJson());

      _isSubmitting = false;
      emit(const AddProductSuccess());
    } catch (e) {
      _isSubmitting = false;
      emit(AddProductFailure(e.toString()));
    }
  }

  ///================ Update Product ===============///

  Future<void> updateProduct() async {
    try {
      if (_isSubmitting) return;
      if (!formKey.currentState!.validate()) return;

      _isSubmitting = true;
      emit(const AddProductLoading());

      // Upload New Images
      List<String> newImageUrls = [];
      if (images.isNotEmpty) {
        newImageUrls = await _uploadImages(images);
      }

      // Merge Existing Images + New Images
      final allImages = [...existingImages, ...newImageUrls];

      // Update Firestore Document
      final productId = currentProduct!.id;
      await _firestore.collection('products').doc(productId).update({
        'name': nameController.text.trim(),
        'category': categoryController.text.trim(),
        'description': descriptionController.text.trim(),
        'price': double.tryParse(priceController.text.trim()) ?? 0.0,
        'stock': int.tryParse(stockController.text.trim()) ?? 0,
        'images': allImages,
        'imageAsset': allImages.isNotEmpty ? allImages.first : '',
        'thumbnails': allImages,
        'inStock': (int.tryParse(stockController.text.trim()) ?? 0) > 0,
      });

      _isSubmitting = false;
      emit(const UpdateProductSuccess());
    } catch (e) {
      _isSubmitting = false;
      emit(AddProductFailure(e.toString()));
    }
  }

  ///================ Clear Form ===================///

  void clearForm() {
    currentProduct = null;

    nameController.clear();

    categoryController.clear();

    descriptionController.clear();

    priceController.clear();

    stockController.clear();

    images.clear();

    existingImages.clear();

    emit(const AddProductInitial());
  }

  @override
  Future<void> close() {
    nameController.dispose();

    categoryController.dispose();

    descriptionController.dispose();

    priceController.dispose();

    stockController.dispose();

    return super.close();
  }
}