import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMine,
    this.isRead = false,
    this.attachment,
  });

  final String message;
  final String time;
  final bool isMine;
  final bool isRead;
  final Widget? attachment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.l),
      child: Row(
        mainAxisAlignment: isMine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMine) ...[
            const _MessageAvatar(),
            const SizedBox(width: AppSizes.s),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMine
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.72,
                  ),
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: isMine ? AppColors.marketText : AppColors.marketCard,
                    borderRadius: BorderRadius.circular(AppSizes.radiusL),
                    border: isMine
                        ? null
                        : Border.all(color: AppColors.marketBorder),
                    boxShadow: isMine
                        ? null
                        : const [
                            BoxShadow(
                              color: Color(0x08000000),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: MarketTextStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          height: 1.45,
                          color: isMine ? Colors.white : AppColors.marketText,
                        ),
                      ),
                      if (attachment != null) ...[
                        const SizedBox(height: AppSizes.m),
                        attachment!,
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.xs),
                _MessageMeta(time: time, isMine: isMine, isRead: isRead),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageMeta extends StatelessWidget {
  const _MessageMeta({
    required this.time,
    required this.isMine,
    required this.isRead,
  });

  final String time;
  final bool isMine;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          time,
          style: MarketTextStyles.bodySmall.copyWith(
            fontSize: 10,
            color: AppColors.marketTextMuted,
          ),
        ),
        if (isMine && isRead) ...[
          const SizedBox(width: AppSizes.xs),
          const Icon(Icons.done_all, size: 13, color: AppColors.marketGreen),
        ],
      ],
    );
  }
}

class _MessageAvatar extends StatelessWidget {
  const _MessageAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: AppColors.marketInputBg,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person_outline,
        size: 18,
        color: AppColors.marketTextSub,
      ),
    );
  }
}
