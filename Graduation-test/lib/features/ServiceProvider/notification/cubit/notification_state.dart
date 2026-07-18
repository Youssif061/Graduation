part of 'notification_cubit.dart';

sealed class NotificationState {
  const NotificationState();
}

//==========================================
// Initial
//==========================================

final class NotificationInitial
    extends NotificationState {
  const NotificationInitial();
}

//==========================================
// Loading
//==========================================

final class NotificationLoading
    extends NotificationState {
  const NotificationLoading();
}

//==========================================
// Updating
//==========================================

final class NotificationUpdating
    extends NotificationState {
  const NotificationUpdating();
}

//==========================================
// Loaded
//==========================================

final class NotificationLoaded
    extends NotificationState {
  const NotificationLoaded({
    required this.notifications,
  });

  final List<NotificationModel> notifications;
}

//==========================================
// Failure
//==========================================

final class NotificationFailure
    extends NotificationState {
  const NotificationFailure(
    this.message,
  );

  final String message;
}