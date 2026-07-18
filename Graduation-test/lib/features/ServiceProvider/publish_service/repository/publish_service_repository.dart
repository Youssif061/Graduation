import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:expertisemarket/core/services/cloudinary_service.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/model/service_model.dart';

class PublishServiceRepository {
  PublishServiceRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  String get providerId => _auth.currentUser!.uid;

  //----------------------------------------------------------
  // Upload Images To Cloudinary
  //----------------------------------------------------------

  Future<List<String>> uploadImages(
    List<File> images,
  ) async {
    List<String> imageUrls = [];

    for (final image in images) {
      final url = await CloudinaryService.uploadImage(
        image.path,
      );

      imageUrls.add(url);
    }

    return imageUrls;
  }

  //----------------------------------------------------------
  // Publish Service
  //----------------------------------------------------------

  Future<void> publishService(
    ServiceModel service,
  ) async {
    await _firestore
        .collection("services")
        .add(
          service.toMap(),
        );
  }

  //----------------------------------------------------------
  // Update Service
  //----------------------------------------------------------

  Future<void> updateService(
    ServiceModel service,
  ) async {
    await _firestore
        .collection("services")
        .doc(service.id)
        .update(
          service.toMap(),
        );
  }

  //----------------------------------------------------------
  // Delete Service
  //----------------------------------------------------------

  Future<void> deleteService(
    String serviceId,
  ) async {
    await _firestore
        .collection("services")
        .doc(serviceId)
        .delete();
  }
}