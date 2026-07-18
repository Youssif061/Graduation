import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/home_model.dart';

class HomeRepository {
  HomeRepository();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference<Map<String, dynamic>> get _requests =>
      _firestore.collection("requests");

  CollectionReference<Map<String, dynamic>> get _orders =>
      _firestore.collection("orders");
  //----------------------------------------------------------
  // Current Worker
  //----------------------------------------------------------

  String? get currentUserId => _auth.currentUser?.uid;

  //----------------------------------------------------------
  // Collections
  //----------------------------------------------------------

  CollectionReference<Map<String, dynamic>> get _workers =>
      _firestore.collection("workers");

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection("products");

  CollectionReference<Map<String, dynamic>> get _services =>
      _firestore.collection("services");

  //----------------------------------------------------------
  // Load Home Statistics
  //----------------------------------------------------------

  Future<HomeStatsModel> getHomeStats() async {
    try {
      if (currentUserId == null) {
        return HomeStatsModel.empty();
      }

      //------------------------------------------------------
      // Worker Document
      //------------------------------------------------------

      final workerDoc = await _workers.doc(currentUserId).get();

      double rating = 0;

      int reviews = 0;

      if (workerDoc.exists && workerDoc.data() != null) {
        final data = workerDoc.data()!;

        rating = (data["rating"] ?? 0).toDouble();

        reviews = (data["reviews"] ?? 0) as int;
      }
      //------------------------------------------------------
      // Completed Service Jobs
      //------------------------------------------------------

      final completedRequests = await _requests
          .where("workerId", isEqualTo: currentUserId)
          .where("status", isEqualTo: "completed")
          .get();

      //------------------------------------------------------
      // Completed Product Orders
      //------------------------------------------------------

      final completedOrders = await _orders
          .where("providerId", isEqualTo: currentUserId)
          .where("status", isEqualTo: "completed")
          .get();

      //------------------------------------------------------
      // Total Jobs
      //------------------------------------------------------

      final totalJobs =
          completedRequests.docs.length +
          completedOrders
              .docs
              .length; //------------------------------------------------------
      // Return Model
      //------------------------------------------------------

      return HomeStatsModel(
        totalJobs: totalJobs,
        rating: rating,
        reviews: reviews,
      );
    } catch (e) {
      return HomeStatsModel.empty();
    }
  }

  //----------------------------------------------------------
  // Refresh
  //----------------------------------------------------------

  Future<void> refresh() async {
    await getHomeStats();
  }

  //----------------------------------------------------------
  // Update Rating
  //----------------------------------------------------------

  Future<void> updateRating({
    required double rating,
    required int reviews,
  }) async {
    if (currentUserId == null) {
      return;
    }

    await _workers.doc(currentUserId).update({
      "rating": rating,
      "reviews": reviews,
    });
  }

  //----------------------------------------------------------
  // Update Total Jobs
  //----------------------------------------------------------

  Future<void> updateTotalJobs(int totalJobs) async {
    if (currentUserId == null) {
      return;
    }

    // يتم حسابها تلقائياً من المنتجات والخدمات
    // لذلك لا نقوم بتخزينها داخل Firestore.
  }
}
