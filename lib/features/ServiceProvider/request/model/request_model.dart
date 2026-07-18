import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String id;

  // Client
  final String clientId;
  final String clientName;
  final String clientImage;
  final String reviews;

  // Expert
  final String expertId;

  // Request
  final String title;
  final String summary;
  final String description;

  // Budget
  final double minBudget;
  final double maxBudget;

  // Proposal
  final double price;

  // Details
  final String timeline;
  final String location;
  final String status;

  // Images
  final List<String> problemPhotos;

  // Date
  final DateTime createdAt;

  const RequestModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
    required this.reviews,
    required this.expertId,
    required this.title,
    required this.summary,
    required this.description,
    required this.minBudget,
    required this.maxBudget,
    required this.price,
    required this.timeline,
    required this.location,
    required this.status,
    required this.problemPhotos,
    required this.createdAt,
  });

  //--------------------------------------------------
  // Helpers
  //--------------------------------------------------

  String get budget =>
      '\$${minBudget.toStringAsFixed(0)} - \$${maxBudget.toStringAsFixed(0)}';

  String get formattedPrice =>
      '\$${price.toStringAsFixed(0)}';

  bool get isNew =>
      DateTime.now().difference(createdAt).inHours < 24;

  String get timeAgo {
    final diff = DateTime.now().difference(createdAt);

    if (diff.inMinutes < 1) {
      return "Just now";
    }

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min ago";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours} h ago";
    }

    if (diff.inDays < 30) {
      return "${diff.inDays} days ago";
    }

    return "${createdAt.day}/${createdAt.month}/${createdAt.year}";
  }

  //--------------------------------------------------
  // CopyWith
  //--------------------------------------------------

  RequestModel copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? clientImage,
    String? reviews,
    String? expertId,
    String? title,
    String? summary,
    String? description,
    double? minBudget,
    double? maxBudget,
    double? price,
    String? timeline,
    String? location,
    String? status,
    List<String>? problemPhotos,
    DateTime? createdAt,
  }) {
    return RequestModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientImage: clientImage ?? this.clientImage,
      reviews: reviews ?? this.reviews,
      expertId: expertId ?? this.expertId,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      price: price ?? this.price,
      timeline: timeline ?? this.timeline,
      location: location ?? this.location,
      status: status ?? this.status,
      problemPhotos:
          problemPhotos ?? this.problemPhotos,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  //--------------------------------------------------
  // To Map
  //--------------------------------------------------

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'clientName': clientName,
      'clientImage': clientImage,
      'reviews': reviews,
      'expertId': expertId,
      'title': title,
      'summary': summary,
      'description': description,
      'minBudget': minBudget,
      'maxBudget': maxBudget,
      'price': price,
      'timeline': timeline,
      'location': location,
      'status': status,
      'problemPhotos': problemPhotos,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  //--------------------------------------------------
  // From Map
  //--------------------------------------------------

  factory RequestModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return RequestModel(
      id: id,
      clientId: map['clientId'] ?? '',
      clientName: map['clientName'] ?? '',
      clientImage: map['clientImage'] ?? '',
      reviews: map['reviews'] ?? '',
      expertId: map['expertId'] ?? '',
      title: map['title'] ?? '',
      summary: map['summary'] ?? '',
      description: map['description'] ?? '',
      minBudget: (map['minBudget'] as num?)?.toDouble() ?? 0,
      maxBudget: (map['maxBudget'] as num?)?.toDouble() ?? 0,
      price: (map['price'] as num?)?.toDouble() ?? 0,
      timeline: map['timeline'] ?? '',
      location: map['location'] ?? '',
      status: map['status'] ?? 'Pending',
      problemPhotos:
          List<String>.from(map['problemPhotos'] ?? []),
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}