import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/styles/colors.dart';

class TrackOrderHeader extends StatelessWidget {
  const TrackOrderHeader({
    super.key,
    this.onBack,
  });

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: AppColors.navyColor,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          const Expanded(
            child: Text(
              'ExpertiseMarket',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                height: 1.2,
                color: AppColors.navyColor,
              ),
            ),
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.inputBorderColor,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person,
              size: 26,
              color: AppColors.navyColor,
            ),
          ),
        ],
      ),
    );
  }
}