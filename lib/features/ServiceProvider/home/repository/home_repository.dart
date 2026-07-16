import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/home_model.dart';

class HomeRepository {
  HomeRepository();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser!.uid;

  CollectionReference get _providers =>
      _firestore.collection('serviceProviders');

  Future<HomeStatsModel> getHomeStats() async {
    final document =
        await _providers.doc(currentUserId).get();

    if (!document.exists) {
      return HomeStatsModel.empty();
    }

    final data = document.data();

    if (data == null) {
      return HomeStatsModel.empty();
    }

    return HomeStatsModel.fromMap(
      data as Map<String, dynamic>,
    );
  }

  Future<void> refresh() async {
    await getHomeStats();
  }
}