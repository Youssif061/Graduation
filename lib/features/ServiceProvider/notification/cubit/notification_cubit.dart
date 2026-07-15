import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// جميع الإشعارات
  List<NotificationModel> notifications = [];

  ///===============================================
  /// Load Notifications
  ///===============================================

  Future<void> loadNotifications() async {
    try {
      emit(const NotificationLoading());

      final snapshot = await _firestore
          .collection("notifications")
          .orderBy("createdAt", descending: true)
          .get();

      notifications = snapshot.docs
          .map(
            (doc) => NotificationModel.fromJson(
              doc.data(),
              doc.id,
            ),
          )
          .toList();

      emit(
        NotificationLoaded(
          List.from(notifications),
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

  ///===============================================
  /// Mark All As Read
  ///===============================================

  Future<void> markAllAsRead() async {
    try {
      emit(const NotificationUpdating());

      final batch = _firestore.batch();

      for (final notification in notifications) {
        if (!notification.isRead) {
          batch.update(
            _firestore
                .collection("notifications")
                .doc(notification.id),
            {
              "isRead": true,
            },
          );
        }
      }

      await batch.commit();

      await loadNotifications();
    } catch (e) {
      emit(
        NotificationFailure(
          e.toString(),
        ),
      );
    }
  }

  ///===============================================
  /// Delete Notification
  ///===============================================

  Future<void> deleteNotification(String id) async {
    try {
      emit(const NotificationUpdating());

      await _firestore
          .collection("notifications")
          .doc(id)
          .delete();

      notifications.removeWhere(
        (element) => element.id == id,
      );

      emit(
        NotificationLoaded(
          List.from(notifications),
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

  ///===============================================
  /// Refresh
  ///===============================================

  Future<void> refresh() async {
    await loadNotifications();
  }
}