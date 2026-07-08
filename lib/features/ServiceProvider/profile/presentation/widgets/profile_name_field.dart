import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileNameField extends StatelessWidget {
  const ProfileNameField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.marketCard,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        border: Border.all(color: AppColors.marketBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FULL NAME',
            style: MarketTextStyles.sectionLabel.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.marketTextMuted,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: AppSizes.s),
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.marketInputBg,
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: TextField(
              controller: controller,
              style: MarketTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.marketText,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
