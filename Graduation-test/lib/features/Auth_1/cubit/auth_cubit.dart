import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'auth_state.dart';
import 'worker_signup_state.dart';

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
    emit(const AuthLoading());

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user!;

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'image': imageUrl,
        'role': 'user',
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await user.sendEmailVerification();

      await _auth.signOut();

      emit(
        const AuthNeedEmailVerification(
          message: "Account created successfully. Please verify your email.",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Sign Up Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpUserWithApple() async {
    emit(const AuthLoading());

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

      final doc = await _firestore.collection("users").doc(user.uid).get();

      if (!doc.exists) {
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": user.displayName ?? "",
          "email": user.email ?? "",
          "phone": "",
          "image": user.photoURL ?? "",
          "role": "user",
          "isVerified": true,
          "createdAt": FieldValue.serverTimestamp(),
        });
      }

      await _auth.signOut();

      emit(
        const AuthNeedEmailVerification(
          message: "Account created successfully. Please login.",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Apple Sign Up Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpUserWithGoogle() async {
    emit(const AuthLoading());

    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(const AuthInitial());
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user!;

      final doc = await _firestore.collection("users").doc(user.uid).get();

      if (!doc.exists) {
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "name": user.displayName ?? "",
          "email": user.email ?? "",
          "phone": "",
          "image": user.photoURL ?? "",
          "role": "user",
          "isVerified": true,
          "createdAt": FieldValue.serverTimestamp(),
        });
      }
      await GoogleSignIn().signOut();

      await _auth.signOut();

      emit(
        const AuthNeedEmailVerification(
          message: "Account created successfully. Please login.",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Google Sign Up Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<User?> signUpWorkerWithGoogle() async {
    emit(const AuthLoading());

    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(const AuthInitial());
        return null;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Google Sign Up Failed"));
      return null;
    } catch (e) {
      emit(AuthError(e.toString()));
      return null;
    }
  }

  Future<String> getUserRole(String uid) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();

    if (userDoc.exists) {
      return "user";
    }

    final workerDoc = await _firestore.collection('workers').doc(uid).get();

    if (workerDoc.exists) {
      return "worker";
    }

    throw Exception("Account data not found");
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await credential.user!.reload();

      final user = _auth.currentUser!;

      if (!user.emailVerified) {
        await _auth.signOut();

        emit(
          const AuthNeedEmailVerification(
            message: "Please verify your email first.",
          ),
        );
        return;
      }

      final role = await getUserRole(user.uid);

      emit(AuthSuccess(role: role));
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
    emit(const AuthLoading());

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final user = credential.user!;

      await _firestore.collection('workers').doc(user.uid).set({
        'uid': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'image': imageUrl,
        'category': category,
        'experience': experience,
        'nationalId': nationalId,
        'location': GeoPoint(latitude, longitude),
        'serviceRadius': radius,
        'role': 'worker',
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await user.sendEmailVerification();

      await _auth.signOut();

      emit(
        const AuthNeedEmailVerification(
          message: "Account created successfully. Please verify your email.",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Worker Sign Up Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> completeWorkerRegistration(WorkerSignupState worker) async {
    emit(const AuthLoading());

    try {
      User? user = _auth.currentUser;

      if (worker.signupMethod == SignupMethod.email) {
        final credential = await _auth.createUserWithEmailAndPassword(
          email: worker.email.trim(),
          password: worker.password.trim(),
        );

        user = credential.user;

        await user!.sendEmailVerification();
      }

      if (user == null) {
        emit(const AuthError("User not found."));
        return;
      }

      await _firestore.collection("workers").doc(user.uid).set({
        "uid": user.uid,
        "name": worker.name,
        "email": worker.email,
        "phone": worker.phone,
        "image": worker.imagePath,
        "category": worker.category,
        "experience": worker.experience,
        "nationalId": worker.nationalId,
        "location": GeoPoint(
          worker.location!.latitude,
          worker.location!.longitude,
        ),
        "serviceRadius": worker.radius,
        "role": "worker",
        "isVerified": worker.signupMethod != SignupMethod.email,
        "createdAt": FieldValue.serverTimestamp(),
      });

      if (worker.signupMethod != SignupMethod.email) {
        await GoogleSignIn().signOut();
        await _auth.signOut();
      } else {
        await _auth.signOut();
      }

      emit(
        const AuthNeedEmailVerification(
          message: "Worker account created successfully.",
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Registration Failed"));
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
    emit(const AuthLoading());

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

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Apple Sign Up Failed"));
      return null;
    } catch (e) {
      emit(AuthError(e.toString()));
      return null;
    }
  }

  Future<void> loginWithGoogle() async {
    emit(const AuthLoading());

    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(const AuthInitial());
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      final role = await getUserRole(userCredential.user!.uid);

      emit(AuthSuccess(role: role));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Google Login Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> loginWithApple() async {
    emit(const AuthLoading());

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

      final role = await getUserRole(userCredential.user!.uid);

      emit(AuthSuccess(role: role));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Apple Login Failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
