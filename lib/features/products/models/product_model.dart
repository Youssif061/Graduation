class ProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final String imageAsset;
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

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageAsset,
    required this.price,
    this.originalPrice = 0.0,
    required this.rating,
    required this.reviewCount,
    this.isNew = false,
    this.inStock = true,
    this.storeName = '',
    this.storeRating = 0.0,
    this.storeProducts = '',
    this.bulletPoints = const [],
    this.specs = const {},
    this.thumbnails = const [],
  });
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
}
