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
          _firestore.collection('requests');

  //--------------------------------------------------
  // Current Service Provider
  //--------------------------------------------------

  String? get currentProviderId =>
      _auth.currentUser?.uid;

  //--------------------------------------------------
  // Get Requests
  //--------------------------------------------------

  Future<List<RequestModel>> getRequests() async {
    try {
      final providerId = currentProviderId;

      // المستخدم غير مسجل دخول
      if (providerId == null) {
        return [];
      }

      final snapshot = await _requests
          .where(
            'expertId',
            isEqualTo: providerId,
          )
          .orderBy(
            'createdAt',
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
    } on FirebaseException {
      return [];
    } catch (_) {
      return [];
    }
  }

  //--------------------------------------------------
  // Accept Request
  //--------------------------------------------------

  Future<void> acceptRequest(
    String requestId,
  ) async {
    try {
      final providerId = currentProviderId;

      if (providerId == null) {
        return;
      }

      await _requests.doc(requestId).update({
        'status': 'In Progress',
      });
    } catch (_) {}
  }

  //--------------------------------------------------
  // Reject Request
  //--------------------------------------------------

  Future<void> rejectRequest(
    String requestId,
  ) async {
    try {
      final providerId = currentProviderId;

      if (providerId == null) {
        return;
      }

      await _requests
          .doc(requestId)
          .delete();
    } catch (_) {}
  }

  //--------------------------------------------------
  // Update Proposal Price
  //--------------------------------------------------

  Future<void> updateProposalPrice({
    required String requestId,
    required double price,
  }) async {
    try {
      final providerId = currentProviderId;

      if (providerId == null) {
        return;
      }

      await _requests.doc(requestId).update({
        'price': price,
      });
    } catch (_) {}
  }

  //--------------------------------------------------
  // Update Request Status
  //--------------------------------------------------

  Future<void> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    try {
      final providerId = currentProviderId;

      if (providerId == null) {
        return;
      }

      await _requests.doc(requestId).update({
        'status': status,
      });
    } catch (_) {}
  }

  //--------------------------------------------------
  // Get Request By Id
  //--------------------------------------------------

  Future<RequestModel?> getRequestById(
    String requestId,
  ) async {
    try {
      final providerId = currentProviderId;

      if (providerId == null) {
        return null;
      }

      final document =
          await _requests.doc(requestId).get();

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
    } on FirebaseException {
      return null;
    } catch (_) {
      return null;
    }
  }
}