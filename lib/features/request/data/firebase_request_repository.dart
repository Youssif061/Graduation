import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/service_request_model.dart';

class FirebaseRequestRepository {
  FirebaseRequestRepository({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
    FirebaseAuth? auth,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance,
       _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;

  Future<String> createRequest({
    required ServiceRequestModel request,
    XFile? photo,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw const RequestRepositoryException(
        'You must be signed in before posting a request.',
      );
    }

    final documentReference = _firestore.collection('service_requests').doc();

    Reference? uploadedPhotoReference;
    final imageUrls = <String>[];

    try {
      if (photo != null) {
        final extension = _fileExtension(photo.name);

        uploadedPhotoReference = _storage.ref().child(
          'service_requests/'
          '${user.uid}/'
          '${documentReference.id}/'
          'request_photo.$extension',
        );

        final file = File(photo.path);
        final metadata = photo.mimeType == null
            ? null
            : SettableMetadata(contentType: photo.mimeType);

        final uploadTask = metadata == null
            ? uploadedPhotoReference.putFile(file)
            : uploadedPhotoReference.putFile(file, metadata);

        final uploadSnapshot = await uploadTask;
        final downloadUrl = await uploadSnapshot.ref.getDownloadURL();

        imageUrls.add(downloadUrl);
      }

      await documentReference.set({
        ...request.toFirestore(
          id: documentReference.id,
          userId: user.uid,
          imageUrls: imageUrls,
        ),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return documentReference.id;
    } on FirebaseException catch (error) {
      await _deleteUploadedPhotoSafely(uploadedPhotoReference);

      throw RequestRepositoryException(
        error.message ?? 'Unable to post the request.',
      );
    } catch (_) {
      await _deleteUploadedPhotoSafely(uploadedPhotoReference);

      throw const RequestRepositoryException(
        'An unexpected error occurred while posting the request.',
      );
    }
  }

  String _fileExtension(String fileName) {
    final parts = fileName.split('.');

    if (parts.length < 2) {
      return 'jpg';
    }

    return parts.last.toLowerCase();
  }

  Future<void> _deleteUploadedPhotoSafely(Reference? reference) async {
    if (reference == null) {
      return;
    }

    try {
      await reference.delete();
    } catch (_) {
      // Cleanup failure must not hide the original Firebase error.
    }
  }
}

class RequestRepositoryException implements Exception {
  const RequestRepositoryException(this.message);

  final String message;

  @override
  String toString() => message;
}
