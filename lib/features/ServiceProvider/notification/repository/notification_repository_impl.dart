import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/notification_model.dart';
import 'notification_repository.dart';

class NotificationRepositoryImpl
    implements NotificationRepository {
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  @override
  Future<List<NotificationModel>>
      loadNotifications() async {
    final snapshot = await firestore
        .collection("notifications")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .get();

    return snapshot.docs
        .map(
          (doc) => NotificationModel.fromJson(
            doc.data(),
            doc.id,
          ),
        )
        .toList();
  }

  @override
  Future<void> markAllAsRead() async {
    final snapshot = await firestore
        .collection("notifications")
        .where(
          "isRead",
          isEqualTo: false,
        )
        .get();

    final batch = firestore.batch();

    for (final doc in snapshot.docs) {
      batch.update(
        doc.reference,
        {
          "isRead": true,
        },
      );
    }

    await batch.commit();
  }

  @override
  Future<void> deleteNotification(
    String notificationId,
  ) async {
    await firestore
        .collection("notifications")
        .doc(notificationId)
        .delete();
  }
}