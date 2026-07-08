import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.onTap,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isUnread = false,
  });

  final String name;
  final String message;
  final String time;
  final VoidCallback onTap;
  final int unreadCount;
  final bool isOnline;
  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.marketCard,
      borderRadius: BorderRadius.circular(AppSizes.radiusL),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusL),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.radiusL),
                border: Border.all(color: AppColors.marketBorder),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _ConversationAvatar(isOnline: isOnline),
                  const SizedBox(width: AppSizes.md),
                  Expanded(
                    child: _ConversationContent(
                      name: name,
                      message: message,
                      time: time,
                      isUnread: isUnread,
                    ),
                  ),
                  const SizedBox(width: AppSizes.s),
                  _ConversationTrailing(unreadCount: unreadCount),
                ],
              ),
            ),
            if (isUnread)
              Positioned(
                left: 0,
                top: AppSizes.md,
                bottom: AppSizes.md,
                child: Container(
                  width: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.marketGreen,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(AppSizes.radiusXS),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ConversationAvatar extends StatelessWidget {
  const _ConversationAvatar({required this.isOnline});

  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.marketInputBg,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
          child: const Icon(
            Icons.person_outline,
            size: 30,
            color: AppColors.marketTextSub,
          ),
        ),
        if (isOnline)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.marketGreen,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.marketCard, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

class _ConversationContent extends StatelessWidget {
  const _ConversationContent({
    required this.name,
    required this.message,
    required this.time,
    required this.isUnread,
  });

  final String name;
  final String message;
  final String time;
  final bool isUnread;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: MarketTextStyles.productTitle.copyWith(
                  fontSize: 16,
                  fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                  color: AppColors.marketText,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.s),
            Text(
              time,
              style: MarketTextStyles.bodySmall.copyWith(
                fontSize: 12,
                fontWeight: isUnread ? FontWeight.w700 : FontWeight.w500,
                color: isUnread
                    ? AppColors.marketGreen
                    : AppColors.marketTextSub,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.xs),
        Text(
          message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: MarketTextStyles.bodySmall.copyWith(
            fontSize: 13,
            height: 1.4,
            fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
            color: isUnread ? AppColors.marketText : AppColors.marketTextSub,
          ),
        ),
      ],
    );
  }
}

class _ConversationTrailing extends StatelessWidget {
  const _ConversationTrailing({required this.unreadCount});

  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Column(
        children: [
          if (unreadCount > 0)
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.marketGreen,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$unreadCount',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            )
          else
            const SizedBox(height: 24),
          const SizedBox(height: AppSizes.s),
          const Icon(
            Icons.chevron_right,
            size: AppSizes.iconM,
            color: AppColors.marketTextSub,
          ),
        ],
      ),
    );
  }
}
