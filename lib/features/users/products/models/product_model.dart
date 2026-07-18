import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String providerId; // expertId
  final String name;
  final String category;
  final String description;
  final String imageAsset; // main image url/path
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final bool isNew;
  final bool inStock;
  final String storeName;
  final double storeRating;
  final String storeProducts;
  final List<String> bulletPoints;
  final Map<String, String> specs;
  final List<String> thumbnails;
  final int stock;
  final List<String> images;
  final DateTime createdAt;
  final String status;

  const ProductModel({
    required this.id,
    required this.providerId,
    required this.name,
    required this.category,
    required this.description,
    required this.imageAsset,
    required this.price,
    this.originalPrice = 0.0,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.isNew = false,
    this.inStock = true,
    this.storeName = 'Verified Expert',
    this.storeRating = 4.8,
    this.storeProducts = '10+',
    this.bulletPoints = const [],
    this.specs = const {},
    this.thumbnails = const [],
    this.stock = 0,
    this.images = const [],
    required this.createdAt,
    this.status = 'active',
  });

  factory ProductModel.fromJson(Map<String, dynamic> json, String documentId) {
    final imgs = List<String>.from(json['images'] ?? const []);
    final thumbs = List<String>.from(json['thumbnails'] ?? const []);
    final mainImg = json['imageAsset'] ?? (imgs.isNotEmpty ? imgs.first : (json['image'] ?? ''));

    return ProductModel(
      id: documentId,
      providerId: json['providerId'] ?? json['expertId'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      imageAsset: mainImg,
      price: (json['price'] ?? 0.0).toDouble(),
      originalPrice: (json['originalPrice'] ?? json['price'] ?? 0.0).toDouble(),
      rating: (json['rating'] ?? 4.5).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      isNew: json['isNew'] ?? false,
      inStock: json['inStock'] ?? ((json['stock'] ?? 0) > 0),
      storeName: json['storeName'] ?? 'Verified Expert',
      storeRating: (json['storeRating'] ?? 4.8).toDouble(),
      storeProducts: json['storeProducts'] ?? '10+',
      bulletPoints: List<String>.from(json['bulletPoints'] ?? const []),
      specs: Map<String, String>.from(json['specs'] ?? const {}),
      thumbnails: thumbs.isNotEmpty ? thumbs : imgs,
      stock: json['stock'] ?? 0,
      images: imgs,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : (json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now()),
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'providerId': providerId,
      'name': name,
      'category': category,
      'description': description,
      'imageAsset': imageAsset,
      'price': price,
      'originalPrice': originalPrice,
      'rating': rating,
      'reviewCount': reviewCount,
      'isNew': isNew,
      'inStock': inStock,
      'storeName': storeName,
      'storeRating': storeRating,
      'storeProducts': storeProducts,
      'bulletPoints': bulletPoints,
      'specs': specs,
      'thumbnails': thumbnails,
      'stock': stock,
      'images': images,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status,
    };
  }

  ProductModel copyWith({
    String? id,
    String? providerId,
    String? name,
    String? category,
    String? description,
    String? imageAsset,
    double? price,
    double? originalPrice,
    double? rating,
    int? reviewCount,
    bool? isNew,
    bool? inStock,
    String? storeName,
    double? storeRating,
    String? storeProducts,
    List<String>? bulletPoints,
    Map<String, String>? specs,
    List<String>? thumbnails,
    int? stock,
    List<String>? images,
    DateTime? createdAt,
    String? status,
  }) {
    return ProductModel(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageAsset: imageAsset ?? this.imageAsset,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isNew: isNew ?? this.isNew,
      inStock: inStock ?? this.inStock,
      storeName: storeName ?? this.storeName,
      storeRating: storeRating ?? this.storeRating,
      storeProducts: storeProducts ?? this.storeProducts,
      bulletPoints: bulletPoints ?? this.bulletPoints,
      specs: specs ?? this.specs,
      thumbnails: thumbnails ?? this.thumbnails,
      stock: stock ?? this.stock,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}

class CartItemModel {
  final String id;
  final String name;
  final String variant;
  final String imageAsset;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.variant,
    required this.imageAsset,
    required this.price,
    this.quantity = 1,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      variant: json['variant'] ?? '',
      imageAsset: json['imageAsset'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'variant': variant,
      'imageAsset': imageAsset,
      'price': price,
      'quantity': quantity,
    };
  }
}

class WishlistItemModel {
  final String id;
  final String name;
  final String description;
  final String imageAsset;
  final double price;
  bool isFavourite;

  WishlistItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageAsset,
    required this.price,
    this.isFavourite = true,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    return WishlistItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageAsset: json['imageAsset'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      isFavourite: json['isFavourite'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageAsset': imageAsset,
      'price': price,
      'isFavourite': isFavourite,
    };
  }
}
