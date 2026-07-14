import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';

class ExpertTipCard extends StatelessWidget {
  const ExpertTipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.marketGreenBadge,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.marketGreen.withValues(alpha: 0.45),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 18,
                color: AppColors.marketGreenDark,
              ),
              SizedBox(width: 8),
              Text(
                'Expert Tip',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.marketGreenDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Adding clear photos increases your response rate and helps experts provide more accurate quotes.',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: AppColors.marketGreenDark,
            ),
          ),
        ],
      ),
    );
  }
}
