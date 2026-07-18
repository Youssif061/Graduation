part of 'publish_service_cubit.dart';

sealed class PublishServiceState {
  const PublishServiceState();
}

/// الحالة الابتدائية
final class PublishServiceInitial extends PublishServiceState {
  const PublishServiceInitial();
}

/// أثناء رفع الصور أو حفظ البيانات
final class PublishServiceLoading extends PublishServiceState {
  const PublishServiceLoading();
}

/// عند تغيير الصور
final class PublishServiceImagesChanged extends PublishServiceState {
  final List<File> images;

  final List<String> existingImages;

  const PublishServiceImagesChanged({
    required this.images,
    required this.existingImages,
  });
}

/// عند نجاح نشر الخدمة
final class PublishServiceSuccess extends PublishServiceState {
  const PublishServiceSuccess();
}

/// عند نجاح تعديل الخدمة
final class PublishServiceUpdated extends PublishServiceState {
  const PublishServiceUpdated();
}

/// عند حذف الخدمة
final class PublishServiceDeleted extends PublishServiceState {
  const PublishServiceDeleted();
}

/// عند حدوث خطأ
final class PublishServiceFailure extends PublishServiceState {
  final String message;

  const PublishServiceFailure(
    this.message,
  );
}