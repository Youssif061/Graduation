import 'package:expertisemarket/features/Auth_1/Pages/SignUp/Main_SignUp.dart';
import 'package:expertisemarket/features/Auth_1/Pages/Welcome_Screen/Pages/Welcome_Screen.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/page/add_product_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/chat/page/chat_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/home/page/home_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/inventory/page/inventory_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/main/main_app_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/notification/page/notification_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/page/publish_service_screen.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/repository/publish_service_repository.dart';
import 'package:expertisemarket/features/ServiceProvider/request/page/requests_screen.dart';
import 'package:expertisemarket/features/SplashScreen/SplashScreen.dart';
import 'package:expertisemarket/features/products/presentation/pages/cart_screen.dart';
import 'package:expertisemarket/features/products/presentation/pages/profile_screen.dart';
import 'package:expertisemarket/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:flutter/material.dart';

// استيراد الـ Bloc والـ Cubits لحقنها في الـ Routes المناسبة
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expertisemarket/features/ServiceProvider/publish_service/cubit/publish_service_cubit.dart';
import 'package:expertisemarket/features/ServiceProvider/add_product/cubit/add_product_cubit.dart';

import 'routers.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.mainSignUp:
        return MaterialPageRoute(builder: (_) => const Sign_up());

      case Routers.main:
        return MaterialPageRoute(builder: (_) => const MainAppScreen());

      case Routers.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routers.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routers.requests:
        return MaterialPageRoute(builder: (_) => const RequestsScreen());

      case Routers.inventory:
        return MaterialPageRoute(builder: (_) => const InventoryScreen());

      case Routers.chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());

      case Routers.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case Routers.notification:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());

      case Routers.publishService:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PublishServiceCubit(PublishServiceRepository()),
            child: const PublishServiceScreen(),
          ),
        );

      // case Routers.publishProposal:
      //   return MaterialPageRoute(builder: (_) => const SendProposalScreen());

      case Routers.addProduct:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AddProductCubit(),
            child: const AddProductScreen(),
          ),
        );

      case Routers.wishlist:
        return MaterialPageRoute(builder: (_) => const WishlistPage());

      case Routers.products:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case Routers.welcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No Route Found'))),
        );
    }
  }
}
