import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/features/users/products/models/product_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final double subtotal;
  final double taxes;
  final double total;
  final String address;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.taxes,
    required this.total,
    this.address = '',
    this.paymentMethod = 'Cash on Delivery',
    this.status = 'Pending',
    required this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json, String documentId) {
    return OrderModel(
      id: documentId,
      userId: json['userId'] ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ?? [],
      subtotal: (json['subtotal'] ?? 0.0).toDouble(),
      taxes: (json['taxes'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      address: json['address'] ?? '',
      paymentMethod: json['paymentMethod'] ?? 'Cash on Delivery',
      status: json['status'] ?? 'Pending',
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: json['updatedAt'] is Timestamp
          ? (json['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items.map((e) => e.toJson()).toList(),
      'subtotal': subtotal,
      'taxes': taxes,
      'total': total,
      'address': address,
      'paymentMethod': paymentMethod,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  OrderModel copyWith({
    String? id, String? userId, List<CartItemModel>? items,
    double? subtotal, double? taxes, double? total,
    String? address, String? paymentMethod, String? status,
    DateTime? createdAt, DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id, userId: userId ?? this.userId,
      items: items ?? this.items, subtotal: subtotal ?? this.subtotal,
      taxes: taxes ?? this.taxes, total: total ?? this.total,
      address: address ?? this.address, paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status, createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
