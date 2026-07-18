import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/request_model.dart';

class RequestRepository {
  RequestRepository();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>>
      get _requests =>
          _firestore.collection("requests");

  String? get _providerId =>
      _auth.currentUser?.uid;

  //--------------------------------------------------
  // Load Requests
  //--------------------------------------------------

  Future<List<RequestModel>> getRequests() async {
    if (_providerId == null) {
      throw Exception("User not logged in");
    }

    try {
      final snapshot = await _requests
          .where(
            "providerId",
            isEqualTo: _providerId,
          )
          .orderBy(
            "createdAt",
            descending: true,
          )
          .get();

      return snapshot.docs
          .map(
            (doc) => RequestModel.fromMap(
              doc.data(),
              doc.id,
            ),
          )
          .toList();
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? "Failed to load requests",
      );
    }
  }

  //--------------------------------------------------
  // Accept Request
  //--------------------------------------------------

  Future<void> acceptRequest(
    String requestId,
  ) async {
    try {
      await _requests.doc(requestId).update({
        "status": "In Progress",
      });
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? "Failed to accept request",
      );
    }
  }

  //--------------------------------------------------
  // Reject Request
  //--------------------------------------------------

  Future<void> rejectRequest(
    String requestId,
  ) async {
    try {
      await _requests.doc(requestId).delete();
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? "Failed to reject request",
      );
    }
  }

  //--------------------------------------------------
  // Update Proposal Price
  //--------------------------------------------------

  Future<void> updateProposalPrice({
    required String requestId,
    required double price,
  }) async {
    try {
      await _requests.doc(requestId).update({
        "price": price,
      });
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ??
            "Failed to update proposal price",
      );
    }
  }

  //--------------------------------------------------
  // Update Status
  //--------------------------------------------------

  Future<void> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    try {
      await _requests.doc(requestId).update({
        "status": status,
      });
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ??
            "Failed to update request status",
      );
    }
  }

  //--------------------------------------------------
  // Get Request By Id
  //--------------------------------------------------

  Future<RequestModel?> getRequestById(
    String requestId,
  ) async {
    try {
      final document =
          await _requests
              .doc(requestId)
              .get();

      if (!document.exists) {
        return null;
      }

      final data = document.data();

      if (data == null) {
        return null;
      }

      return RequestModel.fromMap(
        data,
        document.id,
      );
    } on FirebaseException catch (e) {
      throw Exception(
        e.message ?? "Failed to load request",
      );
    }
  }
}