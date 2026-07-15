class RequestModel {
  final String id;

  /// Client Information
  final String clientId;
  final String clientName;
  final String clientImage;
  final String reviews;

  /// Request Information
  final String title;
  final String summary;
  final String description;

  /// Budget
  final double minBudget;
  final double maxBudget;

  /// Timeline
  final String timeline;

  /// Proposal Price (يعرض داخل الكارد)
  final double price;

  /// Request Location
  final String location;

  /// Open / Closed / In Progress
  final String status;

  /// UI
  final bool isNew;
  final String timeAgo;

  /// Photos
  final List<String> problemPhotos;

  final DateTime createdAt;

  const RequestModel({
    required this.id,
    required this.clientId,
    required this.clientName,
    required this.clientImage,
    required this.reviews,
    required this.title,
    required this.summary,
    required this.description,
    required this.minBudget,
    required this.maxBudget,
    required this.timeline,
    required this.price,
    required this.location,
    required this.status,
    required this.problemPhotos,
    required this.createdAt,
    this.isNew = false,
    this.timeAgo = '',
  });

  String get budget =>
      '\$${minBudget.toStringAsFixed(0)} - \$${maxBudget.toStringAsFixed(0)}';

  String get formattedPrice =>
      '\$${price.toStringAsFixed(0)}';

  RequestModel copyWith({
    String? id,
    String? clientId,
    String? clientName,
    String? clientImage,
    String? reviews,
    String? title,
    String? summary,
    String? description,
    double? minBudget,
    double? maxBudget,
    String? timeline,
    double? price,
    String? location,
    String? status,
    bool? isNew,
    String? timeAgo,
    List<String>? problemPhotos,
    DateTime? createdAt,
  }) {
    return RequestModel(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientImage: clientImage ?? this.clientImage,
      reviews: reviews ?? this.reviews,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      timeline: timeline ?? this.timeline,
      price: price ?? this.price,
      location: location ?? this.location,
      status: status ?? this.status,
      isNew: isNew ?? this.isNew,
      timeAgo: timeAgo ?? this.timeAgo,
      problemPhotos: problemPhotos ?? this.problemPhotos,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'clientName': clientName,
      'clientImage': clientImage,
      'reviews': reviews,
      'title': title,
      'summary': summary,
      'description': description,
      'minBudget': minBudget,
      'maxBudget': maxBudget,
      'timeline': timeline,
      'price': price,
      'location': location,
      'status': status,
      'isNew': isNew,
      'timeAgo': timeAgo,
      'problemPhotos': problemPhotos,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'] ?? '',
      clientId: map['clientId'] ?? '',
      clientName: map['clientName'] ?? '',
      clientImage: map['clientImage'] ?? '',
      reviews: map['reviews'] ?? '',
      title: map['title'] ?? '',
      summary: map['summary'] ?? '',
      description: map['description'] ?? '',
      minBudget: (map['minBudget'] ?? 0).toDouble(),
      maxBudget: (map['maxBudget'] ?? 0).toDouble(),
      timeline: map['timeline'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      location: map['location'] ?? '',
      status: map['status'] ?? 'open',
      isNew: map['isNew'] ?? false,
      timeAgo: map['timeAgo'] ?? '',
      problemPhotos: List<String>.from(map['problemPhotos'] ?? []),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
    );
  }
}