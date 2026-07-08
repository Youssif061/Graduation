import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes/app_router.dart';
import 'core/routes/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase removed for market demo — uncomment below to re-enable:
  // try {
  //   await Firebase.initializeApp();
  // } catch (_) {}

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CraftMarket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00B074),
          brightness: Brightness.light,
        ),
      ),
      initialRoute: Routers.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
