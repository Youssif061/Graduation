import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/styles/colors.dart';
import '../models/track_order_model.dart';

class OrderOverviewCard extends StatelessWidget {
  const OrderOverviewCard({
    super.key,
    required this.order,
  });

  final TrackOrderModel order;

  static const List<String> _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _formatEstimatedDelivery(DateTime dateTime) {
    final DateTime localDate = dateTime.toLocal();
    final String month = _months[localDate.month - 1];
    final int hour = localDate.hour % 12 == 0 ? 12 : localDate.hour % 12;
    final String minute = localDate.minute.toString().padLeft(2, '0');
    final String period = localDate.hour >= 12 ? 'PM' : 'AM';

    return '$month ${localDate.day}, ${localDate.year} • '
        '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyColor.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ORDER ID',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: AppColors.textSecondaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            order.orderId,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
              height: 1.2,
              color: AppColors.navyColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Column(
              children: [
                const Text(
                  'ESTIMATED DELIVERY',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _formatEstimatedDelivery(order.estimatedDelivery),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: AppColors.emeraldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}