import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/chat/models/conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.conversation,
    required this.onBackPressed,
  });

  final ConversationModel conversation;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Container(
        height: 76,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(bottom: BorderSide(color: colorScheme.outlineVariant)),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onBackPressed,
              tooltip: 'Back',
              icon: SvgPicture.asset(
                AppImages.backSvg,
                width: 21,
                height: 21,
                colorFilter: ColorFilter.mode(
                  colorScheme.onSurface,
                  BlendMode.srcIn,
                ),
              ),
            ),
            _ParticipantAvatar(
              photoUrl: conversation.otherParticipantPhotoUrl,
              isOnline: conversation.isOnline,
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.otherParticipantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          conversation.isOnline
                              ? 'Online'
                              : conversation.otherParticipantRole,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: conversation.isOnline
                                ? AppColors.marketGreenDark
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      if (conversation.otherParticipantRole
                          .trim()
                          .isNotEmpty) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.verified_rounded,
                          size: 13,
                          color: AppColors.marketGreenDark,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              tooltip: 'Conversation options',
              icon: Icon(Icons.more_vert_rounded, color: colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParticipantAvatar extends StatelessWidget {
  const _ParticipantAvatar({required this.photoUrl, required this.isOnline});

  final String photoUrl;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 47,
      height: 47,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 47,
            height: 47,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: ClipOval(
              child: photoUrl.trim().isEmpty
                  ? Image.asset(
                      AppImages.User,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _fallback(context);
                      },
                    )
                  : Image.network(
                      photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _fallback(context);
                      },
                    ),
            ),
          ),
          Positioned(
            right: -1,
            bottom: 1,
            child: Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                color: isOnline
                    ? AppColors.marketGreen
                    : colorScheme.onSurfaceVariant,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.surface, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fallback(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(Icons.person_rounded, color: colorScheme.onSurfaceVariant),
    );
  }
}
