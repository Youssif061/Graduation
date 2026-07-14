import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository {
  FirebaseAuthRepository({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw const AuthRepositoryException(
        'You must be signed in to change your password.',
      );
    }

    final email = user.email?.trim() ?? '';

    if (email.isEmpty) {
      throw const AuthRepositoryException(
        'No email address is linked to this account.',
      );
    }

    final usesPasswordProvider = user.providerData.any(
      (provider) => provider.providerId == 'password',
    );

    if (!usesPasswordProvider) {
      throw const AuthRepositoryException(
        'This account does not use an email and password login.',
      );
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (error) {
      throw _mapFirebaseException(error);
    } catch (_) {
      throw const AuthRepositoryException(
        'An unexpected error occurred while changing your password.',
      );
    }
  }

  AuthRepositoryException _mapFirebaseException(FirebaseAuthException error) {
    switch (error.code) {
      case 'wrong-password':
      case 'invalid-credential':
        return const AuthRepositoryException(
          'The current password is incorrect.',
        );

      case 'weak-password':
        return const AuthRepositoryException('The new password is too weak.');

      case 'user-disabled':
        return const AuthRepositoryException('This account has been disabled.');

      case 'user-not-found':
      case 'user-token-expired':
      case 'invalid-user-token':
        return const AuthRepositoryException(
          'Your session has expired. Please sign in again.',
        );

      case 'user-mismatch':
        return const AuthRepositoryException(
          'The provided credentials do not match this account.',
        );

      case 'requires-recent-login':
        return const AuthRepositoryException(
          'Please sign out, sign in again, then retry.',
        );

      case 'too-many-requests':
        return const AuthRepositoryException(
          'Too many attempts. Please wait and try again.',
        );

      case 'network-request-failed':
        return const AuthRepositoryException(
          'Check your internet connection and try again.',
        );

      case 'operation-not-allowed':
        return const AuthRepositoryException(
          'Email and password authentication is not enabled.',
        );

      default:
        return AuthRepositoryException(
          error.message ?? 'Unable to change your password.',
        );
    }
  }
}

class AuthRepositoryException implements Exception {
  const AuthRepositoryException(this.message);

  final String message;

  @override
  String toString() => message;
}
