part of 'publish_service_cubit.dart';

sealed class PublishServiceState {
  const PublishServiceState();
}

/// الحالة الابتدائية
final class PublishServiceInitial
    extends PublishServiceState {
  const PublishServiceInitial();
}

/// أثناء رفع الصور أو نشر الخدمة
final class PublishServiceLoading
    extends PublishServiceState {
  const PublishServiceLoading();
}

/// عند تغيير الصور
final class PublishServiceImagesChanged
    extends PublishServiceState {
  const PublishServiceImagesChanged();
}

/// عند نجاح النشر
final class PublishServiceSuccess
    extends PublishServiceState {
  const PublishServiceSuccess();
}

/// عند حدوث خطأ
final class PublishServiceFailure
    extends PublishServiceState {
  final String message;

  const PublishServiceFailure(
    this.message,
  );
}