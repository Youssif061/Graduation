import 'dart:io';

import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
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

  ///================ Publish Product ===============///

  Future<void> publishProduct() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      emit(const AddProductLoading());

      /// Upload Images To Firebase Storage

      /// Get Images Urls

      /// Save Product To Firestore

      await Future.delayed(
        const Duration(seconds: 1),
      );

      emit(const AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }

  ///================ Update Product ===============///

  Future<void> updateProduct() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      emit(const AddProductLoading());

      /// Upload New Images

      /// Merge Existing Images + New Images

      /// Update Firestore Document

      await Future.delayed(
        const Duration(seconds: 1),
      );

      emit(const UpdateProductSuccess());
    } catch (e) {
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