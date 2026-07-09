import 'dart:io';

import 'package:craftmarket/core/routes/app_router.dart';
import 'package:craftmarket/core/routes/routers.dart';
import 'package:craftmarket/core/styles/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,

      initialRoute: Routes.main,

      onGenerateRoute: AppRouter.generateRoute,

      builder: (context, child) {
        return SafeArea(
          top: false,
          bottom: Platform.isAndroid,
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}