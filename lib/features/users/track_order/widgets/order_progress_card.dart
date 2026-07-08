import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../cubit/track_order_state.dart';
import 'order_progress_step.dart';

class OrderProgressCard extends StatelessWidget {
  const OrderProgressCard({
    super.key,
    required this.state,
  });

  final TrackOrderState state;

  @override
  Widget build(BuildContext context) {
    final steps = state.order.progressSteps;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(
          AppSpacing.cardRadius,
        ),
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
          Text(
            'Order Progress',
            style: ExpertiseTextStyles.screenTitle.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: AppColors.navyColor,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          for (int index = 0; index < steps.length; index++)
            OrderProgressStep(
              step: steps[index],
              visualState: state.visualStateFor(
                steps[index].stage,
              ),
              isLast: index == steps.length - 1,
            ),
        ],
      ),
    );
  }
}