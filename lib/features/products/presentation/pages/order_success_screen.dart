import 'package:flutter/material.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/products/presentation/pages/main_shell.dart';
import 'package:expertisemarket/features/products/models/order_model.dart';
import 'package:expertisemarket/features/products/presentation/pages/track_order_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  final OrderModel order;

  const OrderSuccessScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final idSuffix = order.id.length > 8
        ? order.id.substring(0, 8).toUpperCase()
        : order.id.toUpperCase();
    final itemsCount = order.items.length;
    final totalPaid = order.total.toStringAsFixed(2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.marketGreenBadge,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: AppColors.marketGreen, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'ExpertiseMarket',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.marketText,
                fontFamily: 'Manrope',
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.marketCardLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.marketBorder),
            ),
            child: const Icon(
              Icons.person_outline,
              color: AppColors.marketTextSub,
              size: 20,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.marketBorder,
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Success Icon
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: AppColors.marketGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 24),
            Text(
              'Order Successful!',
              style: MarketTextStyles.successTitle.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.marketText,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your transaction has been processed securely. Our experts are ready to begin.',
              style: MarketTextStyles.successBody.copyWith(
                color: AppColors.marketTextSub,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Order summary card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  // Order ID
                  _InfoRow(
                    label: 'ORDER ID',
                    value: '#EM-$idSuffix',
                    valueColor: AppColors.marketGreenDark,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Color(0xFFE2E8F0)),
                  ),
                  // Summary
                  _InfoRow(
                    label: 'SUMMARY',
                    value: 'Items: $itemsCount  |  Total: \$$totalPaid',
                    valueColor: AppColors.marketText,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Track Order button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrackOrderScreen(
                      orderId: order.id,
                      initialOrder: order,
                    ),
                  ),
                );
              },
              child: Container(
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.marketText, // Dark slate/navy
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.local_shipping_outlined, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Track Order',
                      style: MarketTextStyles.buttonText.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Continue Shopping button
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const MainShell()),
                  (route) => false,
                );
              },
              child: Container(
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, color: AppColors.marketText, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'Continue Shopping',
                      style: MarketTextStyles.buttonText.copyWith(
                        color: AppColors.marketText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF94A3B8),
            letterSpacing: 1.0,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: valueColor,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
