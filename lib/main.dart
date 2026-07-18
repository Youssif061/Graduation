import 'dart:io';

import 'package:firebase_core/firebase_core.dart' hide FirebaseService;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_router.dart';
import 'core/styles/themes.dart';
import 'features/Auth_1/cubit/auth_cubit.dart';
import 'features/users/data/firebase_service.dart';
import 'features/users/products/presentation/cubit/cart_cubit.dart';
import 'features/users/products/presentation/cubit/order_cubit.dart';
import 'features/users/products/presentation/cubit/product_cubit.dart';
import 'features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Seed Mock Data in Firestore asynchronously in background (non-blocking)
  FirebaseService.instance.seedDatabase();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ProductCubit()),
        BlocProvider(create: (_) => CartCubit()..loadCart()),
        BlocProvider(create: (_) => WishlistCubit()..loadWishlist()),
        BlocProvider(create: (_) => OrderCubit()),
      ],
      child: MaterialApp(
        title: 'CraftMarket',

        debugShowCheckedModeBanner: false,

        theme: AppThemes.lightTheme,

        initialRoute: '/',

        onGenerateRoute: AppRouter.generateRoute,

        builder: (context, child) {
          return SafeArea(
            top: false,
            bottom: Platform.isAndroid,
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
