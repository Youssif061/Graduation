import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/home_model.dart';

class HomeRepository {
  HomeRepository();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>>
      get _providers =>
          _firestore.collection(
            'serviceProviders',
          );

  //--------------------------------------------------
  // Current User Id
  //--------------------------------------------------

  String? get currentUserId =>
      _auth.currentUser?.uid;

  //--------------------------------------------------
  // Get Home Statistics
  //--------------------------------------------------

  Future<HomeStatsModel> getHomeStats() async {
    try {
      final uid = currentUserId;

      // لم يتم تسجيل الدخول بعد
      if (uid == null) {
        return HomeStatsModel.empty();
      }

      final document =
          await _providers.doc(uid).get();

      // لا توجد بيانات للمستخدم
      if (!document.exists) {
        return HomeStatsModel.empty();
      }

      final data = document.data();

      if (data == null) {
        return HomeStatsModel.empty();
      }

      return HomeStatsModel.fromMap(data);
    } on FirebaseException {
      // في حالة عدم ربط Firebase أو أي خطأ
      return HomeStatsModel.empty();
    } catch (_) {
      return HomeStatsModel.empty();
    }
  }

  //--------------------------------------------------
  // Refresh
  //--------------------------------------------------

  Future<HomeStatsModel> refresh() async {
    return await getHomeStats();
  }

  //--------------------------------------------------
  // Update Total Jobs
  //--------------------------------------------------

  Future<void> updateTotalJobs(
    int totalJobs,
  ) async {
    final uid = currentUserId;

    if (uid == null) return;

    await _providers.doc(uid).set(
      {
        'totalJobs': totalJobs,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  //--------------------------------------------------
  // Update Rating
  //--------------------------------------------------

  Future<void> updateRating({
    required double rating,
    required int reviews,
  }) async {
    final uid = currentUserId;

    if (uid == null) return;

    await _providers.doc(uid).set(
      {
        'rating': rating,
        'reviews': reviews,
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}