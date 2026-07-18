// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductModel {
//   final String id;

//   final String providerId;

//   final String name;

//   final String category;

//   final String description;

//   final double price;

//   final int stock;

//   final List<String> images;

//   final DateTime createdAt;

//   const ProductModel({
//     required this.id,
//     required this.providerId,
//     required this.name,
//     required this.category,
//     required this.description,
//     required this.price,
//     required this.stock,
//     required this.images,
//     required this.createdAt,
//   });

//   factory ProductModel.fromJson(
//     Map<String, dynamic> json,
//     String documentId,
//   ) {
//     return ProductModel(
//       id: documentId,
//       providerId: json["providerId"] ?? "",
//       name: json["name"] ?? "",
//       category: json["category"] ?? "",
//       description: json["description"] ?? "",
//       price: (json["price"] ?? 0).toDouble(),
//       stock: (json["stock"] ?? 0) as int,
//       images: List<String>.from(
//         json["images"] ?? const [],
//       ),
//       createdAt: json["createdAt"] is Timestamp
//           ? (json["createdAt"] as Timestamp)
//               .toDate()
//           : DateTime.now(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "providerId": providerId,
//       "name": name,
//       "category": category,
//       "description": description,
//       "price": price,
//       "stock": stock,
//       "images": images,
//       "createdAt":
//           Timestamp.fromDate(createdAt),
//     };
//   }

//   ProductModel copyWith({
//     String? id,
//     String? providerId,
//     String? name,
//     String? category,
//     String? description,
//     double? price,
//     int? stock,
//     List<String>? images,
//     DateTime? createdAt,
//   }) {
//     return ProductModel(
//       id: id ?? this.id,
//       providerId:
//           providerId ?? this.providerId,
//       name: name ?? this.name,
//       category:
//           category ?? this.category,
//       description:
//           description ?? this.description,
//       price: price ?? this.price,
//       stock: stock ?? this.stock,
//       images: images ?? this.images,
//       createdAt:
//           createdAt ?? this.createdAt,
//     );
//   }

//   @override
//   String toString() {
//     return '''
// ProductModel(
//   id: $id,
//   providerId: $providerId,
//   name: $name,
//   category: $category,
//   price: $price,
//   stock: $stock
// )
// ''';
//   }

//   @override
//   bool operator ==(Object other) {
//     return identical(this, other) ||
//         other is ProductModel &&
//             runtimeType == other.runtimeType &&
//             id == other.id;
//   }

//   @override
//   int get hashCode => id.hashCode;
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;

  final String providerId;

  final String name;

  final String category;

  final String description;

  final double price;

  final int stock;

  final List<String> images;

  final DateTime createdAt;


  const ProductModel({
    required this.id,
    required this.providerId,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.stock,
    required this.images,
    required this.createdAt,
  });



  //==========================================================
  // Firestore Convert
  //==========================================================

  factory ProductModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {

    final data = doc.data() ?? {};

    return ProductModel(
      id: doc.id,

      providerId:
      data['providerId'] ?? "",

      name:
      data['name'] ?? "",

      category:
      data['category'] ?? "",

      description:
      data['description'] ?? "",

      price:
      (data['price'] ?? 0).toDouble(),

      stock:
      data['stock'] ?? 0,

      images:
      List<String>.from(
        data['images'] ?? [],
      ),

      createdAt:
      data['createdAt'] is Timestamp
          ? (data['createdAt'] as Timestamp)
          .toDate()
          : DateTime.now(),
    );
  }



  //==========================================================
  // Json Convert
  //==========================================================

  factory ProductModel.fromJson(
      Map<String, dynamic> json,
      String documentId,
      ) {

    return ProductModel(
      id: documentId,

      providerId:
      json["providerId"] ?? "",

      name:
      json["name"] ?? "",

      category:
      json["category"] ?? "",

      description:
      json["description"] ?? "",

      price:
      (json["price"] ?? 0).toDouble(),

      stock:
      json["stock"] ?? 0,

      images:
      List<String>.from(
        json["images"] ?? [],
      ),

      createdAt:
      json["createdAt"] is Timestamp
          ? (json["createdAt"] as Timestamp)
          .toDate()
          : DateTime.now(),
    );
  }



  Map<String,dynamic> toJson(){

    return {

      "providerId": providerId,

      "name": name,

      "category": category,

      "description": description,

      "price": price,

      "stock": stock,

      "images": images,

      "createdAt":
      Timestamp.fromDate(createdAt),

    };
  }



  ProductModel copyWith({

    String? id,

    String? providerId,

    String? name,

    String? category,

    String? description,

    double? price,

    int? stock,

    List<String>? images,

    DateTime? createdAt,

  }){

    return ProductModel(

      id:
      id ?? this.id,

      providerId:
      providerId ?? this.providerId,

      name:
      name ?? this.name,

      category:
      category ?? this.category,

      description:
      description ?? this.description,

      price:
      price ?? this.price,

      stock:
      stock ?? this.stock,

      images:
      images ?? this.images,

      createdAt:
      createdAt ?? this.createdAt,

    );
  }



  @override
  bool operator ==(Object other){

    return identical(this, other) ||
        other is ProductModel &&
            id == other.id;

  }


  @override
  int get hashCode => id.hashCode;
}