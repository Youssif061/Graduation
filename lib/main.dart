import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'core/routes/routers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routers.changePassword,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}