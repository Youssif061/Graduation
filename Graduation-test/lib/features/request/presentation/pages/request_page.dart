import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_circle_outline,
              color: AppColors.marketGreen,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text('Request', style: MarketTextStyles.sectionTitle),
            const SizedBox(height: 8),
            Text('Post a service request', style: MarketTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
