import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/chat_message_type.dart';
import '../../models/conversation_model.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    super.key,
    required this.conversation,
    required this.currentUserId,
    required this.onTap,
    required this.onArchivePressed,
    this.isUpdating = false,
  });

  final ConversationModel conversation;
  final String currentUserId;
  final VoidCallback onTap;
  final VoidCallback onArchivePressed;
  final bool isUpdating;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasUnread = conversation.hasUnreadMessages;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: isUpdating ? null : onTap,
        onLongPress: isUpdating ? null : onArchivePressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          constraints: const BoxConstraints(minHeight: 92),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.035),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 4,
                  color: hasUnread ? AppColors.marketGreen : Colors.transparent,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 13, 12, 13),
                    child: Row(
                      children: [
                        _ParticipantAvatar(
                          photoUrl: conversation.otherParticipantPhotoUrl,
                          isOnline: conversation.isOnline,
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      conversation.otherParticipantName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: hasUnread
                                            ? FontWeight.w800
                                            : FontWeight.w700,
                                        color: colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _formatTime(conversation.lastMessageAt),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _messagePreview(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: hasUnread
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: hasUnread
                                            ? colorScheme.onSurface
                                            : colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (isUpdating)
                                    const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.marketGreen,
                                      ),
                                    )
                                  else if (hasUnread)
                                    Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 22,
                                        minHeight: 22,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        color: AppColors.marketGreen,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        conversation.unreadCount > 99
                                            ? '99+'
                                            : '${conversation.unreadCount}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  else
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      size: 22,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _messagePreview() {
    final prefix = conversation.lastMessageIsMine(currentUserId) ? 'You: ' : '';

    switch (conversation.lastMessageType) {
      case ChatMessageType.text:
        return '$prefix${conversation.lastMessage}';

      case ChatMessageType.image:
        return '${prefix}Photo';

      case ChatMessageType.file:
        return '$prefix${conversation.lastMessage.isEmpty ? 'File' : conversation.lastMessage}';
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final difference = today.difference(messageDate).inDays;

    if (difference == 0) {
      return DateFormat('h:mm a').format(dateTime);
    }

    if (difference == 1) {
      return 'Yesterday';
    }

    if (dateTime.year == now.year) {
      return DateFormat('MMM d').format(dateTime);
    }

    return DateFormat('MMM d, y').format(dateTime);
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
      width: 54,
      height: 54,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 54,
            height: 54,
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
                        return _fallbackAvatar(context);
                      },
                    )
                  : Image.network(
                      photoUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _fallbackAvatar(context);
                      },
                    ),
            ),
          ),
          if (isOnline)
            Positioned(
              right: -1,
              bottom: 2,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.marketGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: colorScheme.surface, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _fallbackAvatar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person_rounded,
        size: 30,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}
