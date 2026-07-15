class ProposalModel {
  final String id;

  /// الطلب الذي تم إرسال العرض عليه
  final String requestId;

  /// مقدم الخدمة
  final String providerId;

  /// صاحب الطلب (العميل)
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requestId': requestId,
      'providerId': providerId,
      'clientId': clientId,
      'price': price,
      'duration': duration,
      'message': message,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ProposalModel.fromMap(Map<String, dynamic> map) {
    return ProposalModel(
      id: map['id'] ?? '',
      requestId: map['requestId'] ?? '',
      providerId: map['providerId'] ?? '',
      clientId: map['clientId'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      duration: map['duration'] ?? '',
      message: map['message'] ?? '',
      status: map['status'] ?? 'pending',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
    );
  }
}