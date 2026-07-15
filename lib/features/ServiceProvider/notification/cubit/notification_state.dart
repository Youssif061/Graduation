part of 'notification_cubit.dart';

sealed class NotificationState {
  const NotificationState();
}

/// الحالة الابتدائية
final class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

/// أثناء تحميل الإشعارات
final class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

/// أثناء التحديث (حذف أو Mark All As Read)
final class NotificationUpdating extends NotificationState {
  const NotificationUpdating();
}

/// عند نجاح تحميل البيانات
final class NotificationLoaded extends NotificationState {
  final List<NotificationModel> notifications;

  const NotificationLoaded(this.notifications);
}

/// عند حدوث خطأ
final class NotificationFailure extends NotificationState {
  final String message;

  const NotificationFailure(this.message);
}