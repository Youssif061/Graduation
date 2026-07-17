import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;

  final String title;

  final String message;

  final String icon;

  final bool isRead;

  final bool isVerified;

  final DateTime createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.icon,
    required this.isRead,
    required this.isVerified,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return NotificationModel(
      id: documentId,
      title: json["title"] ?? "",
      message: json["message"] ?? "",
      icon: json["icon"] ?? "",
      isRead: json["isRead"] ?? false,
      isVerified: json["isVerified"] ?? false,
      createdAt: json["createdAt"] is Timestamp
          ? (json["createdAt"] as Timestamp)
              .toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "message": message,
      "icon": icon,
      "isRead": isRead,
      "isVerified": isVerified,
      "createdAt":
          Timestamp.fromDate(createdAt),
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? icon,
    bool? isRead,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      icon: icon ?? this.icon,
      isRead: isRead ?? this.isRead,
      isVerified:
          isVerified ?? this.isVerified,
      createdAt:
          createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return '''
NotificationModel(
  id: $id,
  title: $title,
  isRead: $isRead,
  isVerified: $isVerified,
  createdAt: $createdAt
)
''';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NotificationModel &&
            runtimeType ==
                other.runtimeType &&
            id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}