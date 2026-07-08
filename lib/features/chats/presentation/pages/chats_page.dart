import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/presentation/widgets/market_app_bar.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline, color: AppColors.marketGreen, size: 60),
            const SizedBox(height: 16),
            Text('Chats', style: MarketTextStyles.sectionTitle),
            const SizedBox(height: 8),
            Text('Your messages will appear here', style: MarketTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
