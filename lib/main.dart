// import 'package:expertisemarket/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'core/routes/app_router.dart';
// import 'core/routes/routers.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CraftMarket',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         fontFamily: GoogleFonts.inter().fontFamily,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF00B074),
//           brightness: Brightness.light,
//         ),
//       ),
//       initialRoute: Routers.splash,
//       onGenerateRoute: AppRouter.generateRoute,
//       builder: (context, child) {
//         return MediaQuery(
//           data: MediaQuery.of(
//             context,
//           ).copyWith(textScaler: TextScaler.linear(1.0)), // hit accessibility
//           child: child!,
//         );
//       },
//     );
//   }
// }

import 'dart:io';
import 'package:expertisemarket/core/routes/routers.dart';
import 'package:expertisemarket/core/routes/app_router.dart';
import 'package:expertisemarket/core/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // 1. استيراد فايربيز
import 'firebase_options.dart'; // 2. استيراد ملف الـ options الخاص بمشروعك
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/products/presentation/cubit/product_cubit.dart';
import 'package:expertisemarket/features/products/presentation/cubit/cart_cubit.dart';
import 'package:expertisemarket/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:expertisemarket/features/products/presentation/cubit/order_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 3. تأمين التهيئة قبل استدعاء أي كود native
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 4. تهيئة فايربيز
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(create: (_) => ProductCubit()),
        BlocProvider<CartCubit>(create: (_) => CartCubit()..loadCart()),
        BlocProvider<WishlistCubit>(create: (_) => WishlistCubit()..loadWishlist()),
        BlocProvider<OrderCubit>(create: (_) => OrderCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      initialRoute: Routers.splash,
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