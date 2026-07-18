import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';

class ProsPage extends StatelessWidget {
  const ProsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.work_outline,
              color: AppColors.marketGreen,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text('Pros', style: MarketTextStyles.sectionTitle),
            const SizedBox(height: 8),
            Text(
              'Professional service providers',
              style: MarketTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
