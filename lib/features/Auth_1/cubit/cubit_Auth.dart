import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';
import 'package:expertisemarket/features/ServiceProvider/main/main_app_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> login(
  GlobalKey<FormState> formKey,
  BuildContext context,
  TextEditingController emailController,
  TextEditingController passwordController,
) async {
  if (!formKey.currentState!.validate()) return;

  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final uid = credential.user?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final role = doc.data()?['role'] ?? 'user';

      if (context.mounted) {
        if (role == 'worker') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainAppScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainShell()),
          );
        }
      }
    }
  } on FirebaseAuthException catch (e) {
    String message;

    switch (e.code) {
      case 'user-not-found':
        message = "No user found for this email.";
        break;

      case 'wrong-password':
        message = "Wrong password.";
        break;

      case 'invalid-email':
        message = "Invalid email.";
        break;

      case 'invalid-credential':
        message = "Email or password is incorrect.";
        break;

      default:
        message = e.message ?? "Login failed.";
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

Future<void> signUp({
  required BuildContext context,
  required String email,
  required String password,
  required String fullName,
  required String phone,
  required String role,
}) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final uid = credential.user?.uid;
    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'fullName': fullName.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (context.mounted) {
        if (role == 'worker') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainAppScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainShell()),
          );
        }
      }
    }
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed.")),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}
