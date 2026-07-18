part of 'add_product_cubit.dart';

sealed class AddProductState {
  const AddProductState();
}

final class AddProductInitial extends AddProductState {
  const AddProductInitial();
}

final class ProductImagesChanged extends AddProductState {
  final List<File> images;

  const ProductImagesChanged(this.images);
}

final class AddProductLoading extends AddProductState {
  const AddProductLoading();
}

final class AddProductSuccess extends AddProductState {
  const AddProductSuccess();
}

final class UpdateProductSuccess extends AddProductState {
  const UpdateProductSuccess();
}

final class AddProductFailure extends AddProductState {
  final String message;

  const AddProductFailure(this.message);
}