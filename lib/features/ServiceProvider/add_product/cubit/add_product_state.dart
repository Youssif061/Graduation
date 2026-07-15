part of 'add_product_cubit.dart';

sealed class AddProductState {
  const AddProductState();
}

/// الحالة الابتدائية
final class AddProductInitial extends AddProductState {
  const AddProductInitial();
}

/// أثناء اختيار الصور
final class ProductImagesChanged extends AddProductState {
  final List<File> images;

  const ProductImagesChanged(this.images);
}

/// أثناء رفع المنتج
final class AddProductLoading extends AddProductState {
  const AddProductLoading();
}

/// عند نجاح إضافة المنتج
final class AddProductSuccess extends AddProductState {
  const AddProductSuccess();
}

/// عند نجاح تعديل المنتج
final class UpdateProductSuccess extends AddProductState {
  const UpdateProductSuccess();
}

/// عند حدوث خطأ
final class AddProductFailure extends AddProductState {
  final String message;

  const AddProductFailure(this.message);
}