import 'package:cloud_firestore/cloud_firestore.dart';

class ProposalModel {
  final String id;

  /// الطلب
  final String requestId;

  /// مقدم الخدمة
  final String providerId;

  /// صاحب الطلب
  final String clientId;

  final double price;

  final String duration;

  final String message;

  /// pending - accepted - rejected
  final String status;

  final DateTime createdAt;

  const ProposalModel({
    required this.id,
    required this.requestId,
    required this.providerId,
    this.clientId = '',
    required this.price,
    required this.duration,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory ProposalModel.fromJson(
    Map<String, dynamic> json,
    String documentId,
  ) {
    return ProposalModel(
      id: documentId,
      requestId: json['requestId'] ?? '',
      providerId: json['providerId'] ?? '',
      clientId: json['clientId'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
      message: json['message'] ?? '',
      status: json['status'] ?? 'pending',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'providerId': providerId,
      'clientId': clientId,
      'price': price,
      'duration': duration,
      'message': message,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  ProposalModel copyWith({
    String? id,
    String? requestId,
    String? providerId,
    String? clientId,
    double? price,
    String? duration,
    String? message,
    String? status,
    DateTime? createdAt,
  }) {
    return ProposalModel(
      id: id ?? this.id,
      requestId: requestId ?? this.requestId,
      providerId: providerId ?? this.providerId,
      clientId: clientId ?? this.clientId,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}