import 'package:expertisemarket/features/SplashScreen/SplashScreen.dart';
import 'package:expertisemarket/features/products/data/dummy_data.dart';
import 'package:expertisemarket/features/products/presentation/pages/cart_screen.dart';
import 'package:expertisemarket/features/products/presentation/pages/checkout_screen.dart';
import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';
import 'package:expertisemarket/features/products/presentation/pages/order_success_screen.dart';
import 'package:expertisemarket/features/products/presentation/pages/product_details_screen.dart';
import 'package:expertisemarket/features/profile/presentation/pages/profile_page.dart';
import 'package:expertisemarket/features/products/presentation/pages/search_screen.dart';
import 'package:expertisemarket/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'routers.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case Routers.mainShell:
        return MaterialPageRoute(
          builder: (_) => const MainShell(),
          settings: settings,
        );
      case Routers.search:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
          settings: settings,
        );
      case Routers.productDetails:
        return MaterialPageRoute(
          builder: (_) =>
              ProductDetailsScreen(product: DummyData.mechanicToolkit),
          settings: settings,
        );
      case Routers.wishlist:
        return MaterialPageRoute(
          builder: (_) => const WishlistPage(),
          settings: settings,
        );
      case Routers.cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
          settings: settings,
        );
      case Routers.checkout:
        return MaterialPageRoute(
          builder: (_) => const CheckoutScreen(),
          settings: settings,
        );
      case Routers.orderSuccess:
        return MaterialPageRoute(
          builder: (_) => const OrderSuccessScreen(),
          settings: settings,
        );
      case Routers.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const _UnknownRouteScreen(),
          settings: settings,
        );
    }
  }
}

class _UnknownRouteScreen extends StatelessWidget {
  const _UnknownRouteScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Route not found')));
  }
}
