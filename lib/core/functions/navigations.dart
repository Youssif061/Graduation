import 'package:flutter/material.dart';

class Navigation {
  Navigation._();

  static Future<dynamic> push(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  static Future<dynamic> pushReplacement(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  static Future<dynamic> pushAndRemoveUntil(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => page,
        ),
      (route) => false,
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void popWithResult(
    BuildContext context,
    dynamic result,
  ) {
    Navigator.pop(context, result);
  }

  static Future<dynamic> pushNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic> pushReplacementNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}