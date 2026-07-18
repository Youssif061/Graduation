part of 'add_product_cubit.dart';

sealed class AddProductState {
  const AddProductState();
}

//==========================================================
// Initial
//==========================================================

final class AddProductInitial extends AddProductState {
  const AddProductInitial();
}

//==========================================================
// Images Changed
//==========================================================

final class ProductImagesChanged extends AddProductState {
  final List<File> images;

  final List<String> existingImages;

  const ProductImagesChanged({
    required this.images,
    required this.existingImages,
  });
}

//==========================================================
// Loading
//==========================================================

final class AddProductLoading extends AddProductState {
  const AddProductLoading();
}

//==========================================================
// Add Success
//==========================================================

final class AddProductSuccess extends AddProductState {
  const AddProductSuccess();
}

//==========================================================
// Update Success
//==========================================================

final class UpdateProductSuccess extends AddProductState {
  const UpdateProductSuccess();
}

//==========================================================
// Delete Success
//==========================================================

final class DeleteProductSuccess extends AddProductState {
  const DeleteProductSuccess();
}

//==========================================================
// Failure
//==========================================================

final class AddProductFailure extends AddProductState {
  final String message;

  const AddProductFailure(this.message);
}