import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/service_model.dart';

class PublishServiceRepository {
  PublishServiceRepository({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance,
       _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;

  final FirebaseStorage _storage;

  final FirebaseAuth _auth;

  String get providerId => _auth.currentUser!.uid;

  //--------------------------------------------------------
  // Upload Images
  //--------------------------------------------------------

  Future<List<String>> uploadImages(List<File> images) async {
    final List<String> imageUrls = [];

    for (final image in images) {
      final fileName =
          "${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}";

      final ref = _storage
          .ref()
          .child("services")
          .child(providerId)
          .child(fileName);

      await ref.putFile(image);

      final url = await ref.getDownloadURL();

      imageUrls.add(url);
    }

    return imageUrls;
  }

  //--------------------------------------------------------
  // Publish Service
  //--------------------------------------------------------

  Future<void> publishService(ServiceModel service) async {
    await _firestore.collection("services").add(service.toMap());
  }
}
