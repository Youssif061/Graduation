import 'package:expertisemarket/features/SplashScreen/SplashScreen.dart';
import 'package:expertisemarket/features/users/track_order/track_order_screen.dart';
import 'package:expertisemarket/features/users/track_order/models/track_order_model.dart';
import 'package:expertisemarket/features/users/track_order/data/track_order_demo_data.dart';
import 'package:flutter/material.dart';
import 'routers.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routers.changePassword:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case Routers.trackOrder:
        return MaterialPageRoute(
          builder: (_) => TrackOrderScreen(
            order: settings.arguments as TrackOrderModel? ?? demoTrackOrder,
          ),
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
