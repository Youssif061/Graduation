import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/category_model.dart';
import 'models/pro_model.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    final snapshot = await _firestore.collection('categories').get();

    return snapshot.docs
        .map((e) => CategoryModel.fromMap(e.data()))
        .toList();
  }

  Future<List<ProModel>> getProfessionals() async {
    final snapshot = await _firestore.collection('professionals').get();

    return snapshot.docs
        .map((e) => ProModel.fromMap(e.data()))
        .toList();
  }
}