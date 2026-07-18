import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_icon_sizes.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/text_styles.dart';

class SecurityStandardsCard extends StatelessWidget {
  const SecurityStandardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.securityIconBackgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppIcons.securityLock,
              width: AppIconSizes.securityLockWidth,
              height: AppIconSizes.securityLockHeight,
              colorFilter: const ColorFilter.mode(
                AppColors.surfaceColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Security Standards',
                style: ExpertiseTextStyles.sectionTitle,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Your new password must be different from previous passwords and contain at least 8 characters including numbers and special symbols.',
                style: ExpertiseTextStyles.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}