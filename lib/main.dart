import 'package:expertisemarket/core/routes/app_router.dart';
import 'package:expertisemarket/core/routes/routers.dart';
import 'package:expertisemarket/core/styles/themes.dart';
import 'package:expertisemarket/core/theme/theme_cubit.dart';
import 'package:expertisemarket/core/theme/theme_state.dart';
import 'package:expertisemarket/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final preferences = await SharedPreferences.getInstance();

  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(preferences: preferences),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'ExpertiseMarket',
          debugShowCheckedModeBanner: false,
          theme: Appthem.light,
          darkTheme: Appthem.dark,
          themeMode: themeState.themeMode,
          initialRoute: Routers.splash,
          onGenerateRoute: AppRouter.generateRoute,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1)),
              child: child!,
            );
          },
        );
      },
    );
  }
}
