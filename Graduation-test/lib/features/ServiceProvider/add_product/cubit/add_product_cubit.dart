import 'dart:io';

import 'package:expertisemarket/features/ServiceProvider/add_product/data/add_product_repository.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(const AddProductInitial());

  final AddProductRepository repository = AddProductRepository();

  //================ Controllers =================//

  final nameController = TextEditingController();

  final categoryController = TextEditingController();

  final descriptionController = TextEditingController();

  final priceController = TextEditingController();

  final stockController = TextEditingController();

  //================ Form =================//

  final formKey = GlobalKey<FormState>();

  //================ Images =================//

  final ImagePicker picker = ImagePicker();

  final List<File> images = [];

  final List<String> existingImages = [];

  ProductModel? currentProduct;

  //================ Load Product =================//

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

  //================ Pick Images =================//

  Future<void> pickImages() async {
    try {
      final picked = await picker.pickMultiImage();

      if (picked.isEmpty) return;

      images.addAll(
        picked.map(
          (e) => File(e.path),
        ),
      );

      emit(ProductImagesChanged(List.from(images)));
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }

  //================ Remove Image =================//

  void removeImage(int index) {
    images.removeAt(index);

    emit(ProductImagesChanged(List.from(images)));
  }

  void removeExistingImage(int index) {
    existingImages.removeAt(index);

    emit(ProductImagesChanged(List.from(images)));
  }

  //================ Add Product =================//

  Future<void> publishProduct() async {
    if (!formKey.currentState!.validate()) return;

    try {
      emit(const AddProductLoading());

      final imageUrls =
          await repository.uploadImages(images);

      final product = ProductModel(
        id: "",
        providerId: repository.providerId,
        name: nameController.text.trim(),
        category: categoryController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text),
        stock: int.parse(stockController.text),
        images: imageUrls,
        createdAt: DateTime.now(),
      );

      await repository.addProduct(product);

      clearForm();

      emit(const AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }

  //================ Update Product =================//

  Future<void> updateProduct() async {
    if (!formKey.currentState!.validate()) return;

    if (currentProduct == null) return;

    try {
      emit(const AddProductLoading());

      List<String> imageUrls = List.from(existingImages);

      if (images.isNotEmpty) {
        final uploaded =
            await repository.uploadImages(images);

        imageUrls.addAll(uploaded);
      }

      final product = currentProduct!.copyWith(
        providerId: repository.providerId,
        name: nameController.text.trim(),
        category: categoryController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text),
        stock: int.parse(stockController.text),
        images: imageUrls,
      );

      await repository.updateProduct(product);

      emit(const UpdateProductSuccess());
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }

  //================ Clear =================//

  void clearForm() {
    currentProduct = null;

    nameController.clear();

    categoryController.clear();

    descriptionController.clear();

    priceController.clear();

    stockController.clear();

    images.clear();

    existingImages.clear();
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