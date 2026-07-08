import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../constants/track_order_icons.dart';
import '../models/track_order_model.dart';

class ServiceAddressCard extends StatelessWidget {
  const ServiceAddressCard({
    super.key,
    required this.order,
  });

  final TrackOrderModel order;

  @override
  Widget build(BuildContext context) {
    final String? addressLine2 = order.serviceAddressLine2;
    final String? deliveryInstructions = order.deliveryInstructions;

    final bool hasAddressLine2 =
        addressLine2 != null && addressLine2.trim().isNotEmpty;

    final bool hasDeliveryInstructions =
        deliveryInstructions != null &&
            deliveryInstructions.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyColor.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                TrackOrderIcons.serviceAddress,
                width: 16,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.navyColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Service Address',
                  style: ExpertiseTextStyles.screenTitle.copyWith(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: AppColors.navyColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            order.serviceLocationName,
            style: ExpertiseTextStyles.label.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            order.serviceAddressLine1,
            style: ExpertiseTextStyles.bodyMedium.copyWith(
              fontSize: 16,
              height: 1.5,
              color: AppColors.textSecondaryColor,
            ),
          ),
          if (hasAddressLine2)
            Text(
              addressLine2,
              style: ExpertiseTextStyles.bodyMedium.copyWith(
                fontSize: 16,
                height: 1.5,
                color: AppColors.textSecondaryColor,
              ),
            ),
          if (hasDeliveryInstructions) ...[
            const SizedBox(height: AppSpacing.sm),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.inputBorderColor.withValues(alpha: 0.7),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'DELIVERY INSTRUCTIONS',
              style: ExpertiseTextStyles.label.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: AppColors.textMutedColor,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '"$deliveryInstructions"',
              style: ExpertiseTextStyles.bodyMedium.copyWith(
                fontSize: 16,
                height: 1.5,
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}