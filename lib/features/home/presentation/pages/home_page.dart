import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.home_outlined,
              color: AppColors.marketGreen,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text('Home', style: MarketTextStyles.sectionTitle),
            const SizedBox(height: 8),
            Text(
              'Welcome to ExpertiseMarket',
              style: MarketTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
