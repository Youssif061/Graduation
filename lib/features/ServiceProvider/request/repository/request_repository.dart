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

  String get currentProviderId {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception(
        'User is not logged in.',
      );
    }

    return user.uid;
  }

  //--------------------------------------------------
  // Get Requests
  //--------------------------------------------------

  Future<List<RequestModel>>
      getRequests() async {
    final snapshot = await _requests
        .where(
          'expertId',
          isEqualTo: currentProviderId,
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
  }

  //--------------------------------------------------
  // Accept Request
  //--------------------------------------------------

  Future<void> acceptRequest(
    String requestId,
  ) async {
    await _requests.doc(requestId).update({
      'status': 'In Progress',
    });
  }

  //--------------------------------------------------
  // Reject Request
  //--------------------------------------------------

  Future<void> rejectRequest(
    String requestId,
  ) async {
    await _requests.doc(requestId).delete();
  }

  //--------------------------------------------------
  // Update Proposal Price
  //--------------------------------------------------

  Future<void> updateProposalPrice({
    required String requestId,
    required double price,
  }) async {
    await _requests.doc(requestId).update({
      'price': price,
    });
  }

  //--------------------------------------------------
  // Update Request Status
  //--------------------------------------------------

  Future<void> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    await _requests.doc(requestId).update({
      'status': status,
    });
  }

  //--------------------------------------------------
  // Get Request By Id
  //--------------------------------------------------

  Future<RequestModel?> getRequestById(
    String requestId,
  ) async {
    final document =
        await _requests.doc(requestId).get();

    if (!document.exists) {
      return null;
    }

    return RequestModel.fromMap(
      document.data()!,
      document.id,
    );
  }
}