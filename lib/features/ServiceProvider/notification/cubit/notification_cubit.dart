import 'package:expertisemarket/features/ServiceProvider/notification/model/notification_model.dart';
import 'package:expertisemarket/features/ServiceProvider/notification/repository/notification_repository.dart';
import 'package:expertisemarket/features/ServiceProvider/notification/repository/notification_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : _repository = NotificationRepositoryImpl(),
        super(const NotificationInitial());

  final NotificationRepository _repository;

  List<NotificationModel> notifications = [];

  //------------------------------------------
  // Load Notifications
  //------------------------------------------

  Future<void> loadNotifications() async {
    try {
      emit(const NotificationLoading());

      notifications =
          await _repository.loadNotifications();

      emit(
        NotificationLoaded(
          notifications:
              List<NotificationModel>.from(
            notifications,
          ),
        ),
      );
    } catch (e) {
      emit(
        NotificationFailure(
          e.toString(),
        ),
      );
    }
  }

  //------------------------------------------
  // Refresh
  //------------------------------------------

  Future<void> refresh() async {
    await loadNotifications();
  }

  //------------------------------------------
  // Mark All As Read
  //------------------------------------------

  Future<void> markAllAsRead() async {
    try {
      emit(const NotificationUpdating());

      await _repository.markAllAsRead();

      notifications = notifications
          .map(
            (notification) =>
                notification.copyWith(
              isRead: true,
            ),
          )
          .toList();

      emit(
        NotificationLoaded(
          notifications:
              List<NotificationModel>.from(
            notifications,
          ),
        ),
      );
    } catch (e) {
      emit(
        NotificationFailure(
          e.toString(),
        ),
      );
    }
  }

  //------------------------------------------
  // Delete Notification
  //------------------------------------------

  Future<void> deleteNotification(
    String notificationId,
  ) async {
    try {
      emit(const NotificationUpdating());

      await _repository.deleteNotification(
        notificationId,
      );

      notifications.removeWhere(
        (notification) =>
            notification.id ==
            notificationId,
      );

      emit(
        NotificationLoaded(
          notifications:
              List<NotificationModel>.from(
            notifications,
          ),
        ),
      );
    } catch (e) {
      emit(
        NotificationFailure(
          e.toString(),
        ),
      );
    }
  }
}