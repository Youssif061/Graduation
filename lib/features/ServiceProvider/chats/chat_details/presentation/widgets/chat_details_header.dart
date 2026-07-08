import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ChatDetailsHeader extends StatelessWidget {
  const ChatDetailsHeader({
    super.key,
    required this.name,
    required this.onBack,
    this.role = 'Expert Advisor',
    this.isOnline = true,
  });

  final String name;
  final String role;
  final bool isOnline;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s),
      decoration: const BoxDecoration(
        color: AppColors.marketCard,
        border: Border(bottom: BorderSide(color: AppColors.marketBorder)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: AppColors.marketText),
          ),
          const _ContactAvatar(),
          const SizedBox(width: AppSizes.m),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: MarketTextStyles.productTitle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.marketText,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    if (isOnline) ...[
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.marketGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSizes.xs),
                    ],
                    Flexible(
                      child: Text(
                        role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MarketTextStyles.bodySmall.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.marketGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactAvatar extends StatelessWidget {
  const _ContactAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: AppColors.marketInputBg,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person_outline,
        size: AppSizes.iconM,
        color: AppColors.marketTextSub,
      ),
    );
  }
}
