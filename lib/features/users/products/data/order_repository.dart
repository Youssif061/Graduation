import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expertisemarket/features/users/products/models/order_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<OrderModel> createOrder(OrderModel order) async {
    final docRef = _firestore.collection('orders').doc();
    final orderWithId = order.copyWith(id: docRef.id);
    await docRef.set(orderWithId.toJson());
    return orderWithId;
  }

  Future<OrderModel?> getOrder(String orderId) async {
    final doc = await _firestore.collection('orders').doc(orderId).get();
    if (!doc.exists || doc.data() == null) return null;
    return OrderModel.fromJson(doc.data()!, doc.id);
  }

  Stream<OrderModel?> trackOrder(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return OrderModel.fromJson(doc.data()!, doc.id);
    });
  }

  Future<List<OrderModel>> getUserOrders(String userId) async {
    final snapshot = await _firestore.collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true).get();
    return snapshot.docs.map((doc) => OrderModel.fromJson(doc.data(), doc.id)).toList();
  }
}
