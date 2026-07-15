class ServiceModel {
  final String id;

  final String providerId;

  final String title;

  final String description;

  final List<String> images;

  final double price;

  final String delivery;

  final bool transportation;

  final bool negotiate;

  final bool active;

  final DateTime createdAt;

  const ServiceModel({
    required this.id,
    required this.providerId,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.delivery,
    required this.transportation,
    required this.negotiate,
    required this.active,
    required this.createdAt,
  });

  ServiceModel copyWith({
    String? id,
    String? providerId,
    String? title,
    String? description,
    List<String>? images,
    double? price,
    String? delivery,
    bool? transportation,
    bool? negotiate,
    bool? active,
    DateTime? createdAt,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      price: price ?? this.price,
      delivery: delivery ?? this.delivery,
      transportation: transportation ?? this.transportation,
      negotiate: negotiate ?? this.negotiate,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "providerId": providerId,
      "title": title,
      "description": description,
      "images": images,
      "price": price,
      "delivery": delivery,
      "transportation": transportation,
      "negotiate": negotiate,
      "active": active,
      "createdAt": createdAt.millisecondsSinceEpoch,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map["id"] ?? "",
      providerId: map["providerId"] ?? "",
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      images: List<String>.from(map["images"] ?? []),
      price: (map["price"] ?? 0).toDouble(),
      delivery: map["delivery"] ?? "",
      transportation: map["transportation"] ?? false,
      negotiate: map["negotiate"] ?? false,
      active: map["active"] ?? true,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map["createdAt"] ?? 0,
      ),
    );
  }
}