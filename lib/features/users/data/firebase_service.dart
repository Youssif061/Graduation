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
        .map((e) => ProModel.fromMap(e.data(), e.id))
        .toList();
  }

  Future<void> seedDatabase() async {
    try {
      final categorySnap = await _firestore.collection('categories').limit(1).get();
      if (categorySnap.docs.isEmpty) {
        final List<Map<String, dynamic>> mockCategories = [
          {'name': 'Plumbing', 'icon': 'plumbing'},
          {'name': 'Electrical', 'icon': 'electrical'},
          {'name': 'HVAC', 'icon': 'hvac'},
          {'name': 'Cleaning', 'icon': 'cleaning'},
        ];
        for (var cat in mockCategories) {
          await _firestore.collection('categories').add(cat);
        }
      }

      final proSnap = await _firestore.collection('professionals').limit(1).get();
      if (proSnap.docs.isEmpty) {
        final List<Map<String, dynamic>> mockPros = [
          {
            'name': 'Emily Carter',
            'job': 'Master Plumber',
            'image': 'emily_carter.jpg',
            'category': 'Plumbing',
            'rating': 4.9,
            'experience': '8 years',
            'price': 45.0,
            'verified': true
          },
          {
            'name': 'Marcus Thorne',
            'job': 'Senior Electrician',
            'image': 'marcus_thorne.jpg',
            'category': 'Electrical',
            'rating': 4.8,
            'experience': '10 years',
            'price': 50.0,
            'verified': true
          },
          {
            'name': 'Alex Rivera',
            'job': 'HVAC Specialist',
            'image': 'alex_rivera.jpg',
            'category': 'HVAC',
            'rating': 4.7,
            'experience': '6 years',
            'price': 55.0,
            'verified': false
          },
          {
            'name': 'Michael Brown',
            'job': 'Professional Cleaner',
            'image': 'michael_brown.jpg',
            'category': 'Cleaning',
            'rating': 4.6,
            'experience': '5 years',
            'price': 30.0,
            'verified': true
          }
        ];
        for (var pro in mockPros) {
          await _firestore.collection('professionals').add(pro);
        }
      }
    } catch (_) {
      // Fail silently or handle error in staging
    }
  }
}