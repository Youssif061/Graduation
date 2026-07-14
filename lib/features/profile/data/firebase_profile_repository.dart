import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_profile_model.dart';

class FirebaseProfileRepository {
  FirebaseProfileRepository({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  }) : _auth = auth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance,
       _storage = storage ?? FirebaseStorage.instance;

  static const String _usersCollection = 'users';
  static const String _profilePhotosFolder = 'profile_photos';

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  Future<UserProfileModel> loadProfile() async {
    try {
      final user = _requireCurrentUser();
      final documentReference = _firestore
          .collection(_usersCollection)
          .doc(user.uid);

      final snapshot = await documentReference.get();
      final data = snapshot.data() ?? <String, dynamic>{};

      final profile = _profileFromSources(user: user, data: data);

      if (!snapshot.exists) {
        await documentReference.set({
          'uid': user.uid,
          'fullName': profile.fullName,
          'email': profile.email,
          'photoUrl': profile.photoUrl,
          'photoStoragePath': profile.photoStoragePath,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      return profile;
    } catch (error) {
      throw _mapException(error);
    }
  }

  Future<UserProfileModel> updateFullName(String fullName) async {
    final normalizedName = fullName.trim();

    if (normalizedName.length < 2) {
      throw const ProfileRepositoryException(
        'Full name must contain at least 2 characters.',
      );
    }

    final user = _requireCurrentUser();
    final previousDisplayName = user.displayName;

    try {
      await user.updateDisplayName(normalizedName);

      await _firestore.collection(_usersCollection).doc(user.uid).set({
        'uid': user.uid,
        'fullName': normalizedName,
        'email': user.email ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return loadProfile();
    } catch (error) {
      await _restoreDisplayNameSafely(user, previousDisplayName);

      throw _mapException(error);
    }
  }

  Future<UserProfileModel> updateProfilePhoto(XFile photo) async {
    final user = _requireCurrentUser();

    final userDocument = _firestore.collection(_usersCollection).doc(user.uid);

    final currentSnapshot = await userDocument.get();
    final currentData = currentSnapshot.data() ?? <String, dynamic>{};

    final previousPhotoUrl = _readString(
      currentData['photoUrl'],
      fallback: user.photoURL ?? '',
    );

    final previousStoragePath = _readString(currentData['photoStoragePath']);

    final extension = _fileExtension(photo.name);
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final newPhotoReference = _storage.ref().child(
      '$_profilePhotosFolder/'
      '${user.uid}/'
      'profile_$timestamp.$extension',
    );

    try {
      final file = File(photo.path);

      final uploadTask = photo.mimeType == null
          ? newPhotoReference.putFile(file)
          : newPhotoReference.putFile(
              file,
              SettableMetadata(contentType: photo.mimeType),
            );

      final uploadSnapshot = await uploadTask;
      final downloadUrl = await uploadSnapshot.ref.getDownloadURL();

      await user.updatePhotoURL(downloadUrl);

      await userDocument.set({
        'uid': user.uid,
        'email': user.email ?? '',
        'photoUrl': downloadUrl,
        'photoStoragePath': newPhotoReference.fullPath,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (previousStoragePath.isNotEmpty &&
          previousStoragePath != newPhotoReference.fullPath) {
        await _deleteStoragePathSafely(previousStoragePath);
      }

      return loadProfile();
    } catch (error) {
      await _deleteReferenceSafely(newPhotoReference);

      await _restorePhotoUrlSafely(user, previousPhotoUrl);

      throw _mapException(error);
    }
  }

  Future<UserProfileModel> deleteProfilePhoto() async {
    final user = _requireCurrentUser();

    final userDocument = _firestore.collection(_usersCollection).doc(user.uid);

    final snapshot = await userDocument.get();
    final data = snapshot.data() ?? <String, dynamic>{};

    final previousPhotoUrl = _readString(
      data['photoUrl'],
      fallback: user.photoURL ?? '',
    );

    final previousStoragePath = _readString(data['photoStoragePath']);

    try {
      await user.updatePhotoURL(null);

      await userDocument.set({
        'uid': user.uid,
        'photoUrl': '',
        'photoStoragePath': '',
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (previousStoragePath.isNotEmpty) {
        await _deleteStoragePathSafely(previousStoragePath);
      }

      return loadProfile();
    } catch (error) {
      await _restorePhotoUrlSafely(user, previousPhotoUrl);

      throw _mapException(error);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      throw _mapException(error);
    }
  }

  UserProfileModel _profileFromSources({
    required User user,
    required Map<String, dynamic> data,
  }) {
    return UserProfileModel.fromMap(
      uid: user.uid,
      data: data,
      fallbackFullName: user.displayName?.trim() ?? '',
      fallbackEmail: user.email?.trim() ?? '',
      fallbackPhotoUrl: user.photoURL?.trim() ?? '',
    );
  }

  User _requireCurrentUser() {
    final user = _auth.currentUser;

    if (user == null) {
      throw const ProfileRepositoryException(
        'You must be signed in to access your profile.',
      );
    }

    return user;
  }

  String _fileExtension(String fileName) {
    final parts = fileName.split('.');

    if (parts.length < 2) {
      return 'jpg';
    }

    final extension = parts.last.toLowerCase();

    const supportedExtensions = {'jpg', 'jpeg', 'png', 'webp', 'heic', 'heif'};

    return supportedExtensions.contains(extension) ? extension : 'jpg';
  }

  String _readString(dynamic value, {String fallback = ''}) {
    final parsedValue = value?.toString().trim() ?? '';

    return parsedValue.isEmpty ? fallback : parsedValue;
  }

  Future<void> _deleteStoragePathSafely(String storagePath) async {
    try {
      await _storage.ref().child(storagePath).delete();
    } catch (_) {
      // Profile data is already updated, so cleanup failure is ignored.
    }
  }

  Future<void> _deleteReferenceSafely(Reference reference) async {
    try {
      await reference.delete();
    } catch (_) {
      // Ignore cleanup errors and preserve the original exception.
    }
  }

  Future<void> _restoreDisplayNameSafely(
    User user,
    String? previousDisplayName,
  ) async {
    try {
      await user.updateDisplayName(previousDisplayName);
    } catch (_) {
      // Ignore rollback errors and preserve the original exception.
    }
  }

  Future<void> _restorePhotoUrlSafely(
    User user,
    String previousPhotoUrl,
  ) async {
    try {
      await user.updatePhotoURL(
        previousPhotoUrl.isEmpty ? null : previousPhotoUrl,
      );
    } catch (_) {
      // Ignore rollback errors and preserve the original exception.
    }
  }

  ProfileRepositoryException _mapException(Object error) {
    if (error is ProfileRepositoryException) {
      return error;
    }

    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return const ProfileRepositoryException(
            'You do not have permission to update this profile.',
          );

        case 'network-request-failed':
          return const ProfileRepositoryException(
            'Check your internet connection and try again.',
          );

        case 'unauthenticated':
          return const ProfileRepositoryException(
            'Your session has expired. Please sign in again.',
          );

        case 'object-not-found':
          return const ProfileRepositoryException(
            'The requested profile photo was not found.',
          );

        default:
          return ProfileRepositoryException(
            error.message ?? 'Unable to update the profile.',
          );
      }
    }

    return const ProfileRepositoryException(
      'An unexpected error occurred while updating the profile.',
    );
  }
}

class ProfileRepositoryException implements Exception {
  const ProfileRepositoryException(this.message);

  final String message;

  @override
  String toString() => message;
}
