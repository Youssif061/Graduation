import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'core/routes/routers.dart';
import 'core/styles/themes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraftMarket',

      debugShowCheckedModeBanner: false,

      theme: AppThemes.lightTheme,

      initialRoute: Routers.main,

      onGenerateRoute:
          AppRouter.generateRoute,

      builder: (
        context,
        child,
      ) {
        return SafeArea(
          top: false,
          bottom: Platform.isAndroid,
          child:
              child ??
              const SizedBox.shrink(),
        );
      },
    );
  }
}