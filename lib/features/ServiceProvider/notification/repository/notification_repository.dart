import '../model/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> loadNotifications();

  Future<void> markAllAsRead();

  Future<void> deleteNotification(
    String notificationId,
  );
}