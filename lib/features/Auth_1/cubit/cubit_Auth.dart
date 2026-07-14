import 'package:expertisemarket/core/functions/navigations.dart';
import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> login(
  GlobalKey<FormState> formKey,
  BuildContext context,
  TextEditingController emailController,
  TextEditingController passwordController,
) async {
  if (!formKey.currentState!.validate()) return;

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    navigationReplacement(context, const MainShell());
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

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
