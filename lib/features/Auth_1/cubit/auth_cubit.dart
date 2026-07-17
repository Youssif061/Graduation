import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String imageUrl,
  }) async {
    emit(AuthLoading());

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User user = credential.user!;

      await user.sendEmailVerification();

      await _auth.signOut();

      await _firestore.collection('users').doc(user.uid).set({
        'image': imageUrl,
        'uid': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'role': 'user',
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(AuthSuccess("user", needEmailVerification: true));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Sign Up Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpUserWithApple() async {
    emit(AuthLoading());

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: null,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);
      final user = userCredential.user!;

      final doc = await _firestore.collection("users").doc(user.uid).get();

      if (!doc.exists) {
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": user.displayName ?? "",
          "email": user.email ?? "",
          "phone": "",
          "image": "",
          "role": "user",
          "isVerified": true,
          "createdAt": FieldValue.serverTimestamp(),
        });
      }

      await checkUserRole(user.uid);
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpUserWithGoogle() async {
    emit(AuthLoading());

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthInitial());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User user = userCredential.user!;
      // نشوف هل الحساب موجود قبل كده
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'phone': '',
          'image': user.photoURL ?? '',
          'role': 'user',
          'isVerified': true,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      await checkUserRole(user.uid);
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<User?> signUpWorkerWithGoogle() async {
    emit(AuthLoading());

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthInitial());
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Google Sign In Failed"));
      return null;
    } catch (e) {
      emit(AuthError(e.toString()));
      return null;
    }
  }

  // تحديد نوع الحساب User او Worker
  Future<void> checkUserRole(String uid) async {
    DocumentSnapshot userDoc = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    if (userDoc.exists) {
      emit(AuthSuccess("user"));
      return;
    }

    DocumentSnapshot workerDoc = await _firestore
        .collection('workers')
        .doc(uid)
        .get();

    if (workerDoc.exists) {
      emit(AuthSuccess("worker"));
      return;
    }

    emit(AuthError("Account data not found"));
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await credential.user!.reload();

      User user = FirebaseAuth.instance.currentUser!;
      if (!user.emailVerified) {
        await _auth.signOut();

        emit(AuthError("Please verify your email first. Check your inbox."));

        return;
      }

      // هنا بدل AuthSuccess()
      // نعرف هو User ولا Worker
      await checkUserRole(user.uid);
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpWorker({
    required String imageUrl,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String category,
    required String experience,
    required String nationalId,
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    emit(AuthLoading());

    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User user = credential.user!;

      await user.sendEmailVerification();

      await _auth.signOut();

      await _firestore.collection('workers').doc(user.uid).set({
        'image': imageUrl,
        'uid': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'category': category,
        'experience': experience,
        'nationalId': nationalId,
        'location': GeoPoint(latitude, longitude),
        'serviceRadius': radius,
        'role': 'worker',
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(AuthSuccess("worker"));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Worker Sign Up Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> completeWorkerRegistration({
    required String imageUrl,
    required String name,
    required String email,
    required String phone,
    required String category,
    required String experience,
    required String nationalId,
    required double latitude,
    required double longitude,
    required double radius,
  }) async {
    emit(AuthLoading());

    try {
      final user = FirebaseAuth.instance.currentUser!;

      await _firestore.collection('workers').doc(user.uid).set({
        'uid': user.uid,
        'image': imageUrl,
        'name': name,
        'email': email,
        'phone': phone,
        'category': category,
        'experience': experience,
        'nationalId': nationalId,
        'location': GeoPoint(latitude, longitude),
        'serviceRadius': radius,
        'role': 'worker',
        'isVerified': true,
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(AuthSuccess("worker"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    emit(AuthInitial());
  }

  Future<User?> signUpWorkerWithApple() async {
    emit(AuthLoading());

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user!;

      return user;
    } catch (e) {
      emit(AuthError(e.toString()));
      return null;
    }
  }
}
