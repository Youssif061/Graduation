import 'dart:io';

import 'package:expertisemarket/core/constants/app_images.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/chat/models/chat_message_model.dart';
import 'package:expertisemarket/features/chat/models/chat_message_type.dart';
import 'package:expertisemarket/features/chat/presentation/widgets/file_attachment_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.otherParticipantPhotoUrl,
    required this.onAttachmentPressed,
  });

  final ChatMessageModel message;
  final String currentUserId;
  final String otherParticipantPhotoUrl;
  final VoidCallback onAttachmentPressed;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine(currentUserId);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: isMine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMine) ...[
            _MessageAvatar(photoUrl: otherParticipantPhotoUrl),
            const SizedBox(width: 9),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMine
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                _buildBubble(context, isMine),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat('h:mm a').format(message.sentAt),
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (isMine) ...[
                      const SizedBox(width: 5),
                      Icon(
                        message.isRead
                            ? Icons.done_all_rounded
                            : Icons.done_rounded,
                        size: 15,
                        color: message.isRead
                            ? AppColors.marketGreen
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(BuildContext context, bool isMine) {
    final colorScheme = Theme.of(context).colorScheme;

    final bubbleColor = isMine ? const Color(0xFF071E33) : colorScheme.surface;

    final textColor = isMine ? Colors.white : colorScheme.onSurface;

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * 0.74,
      ),
      padding: EdgeInsets.all(message.type == ChatMessageType.text ? 13 : 8),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isMine ? 16 : 4),
          bottomRight: Radius.circular(isMine ? 4 : 16),
        ),
        border: isMine ? null : Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: switch (message.type) {
        ChatMessageType.text => Text(
          message.text,
          style: TextStyle(
            fontSize: 14,
            height: 1.45,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        ChatMessageType.file => FileAttachmentCard(
          message: message,
          isMine: isMine,
          onPressed: onAttachmentPressed,
        ),
        ChatMessageType.image => _ImageAttachment(
          imagePath: message.attachmentUrl,
        ),
      },
    );
  }
}

class _MessageAvatar extends StatelessWidget {
  const _MessageAvatar({required this.photoUrl});

  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 31,
      height: 31,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
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
    );
  }

  Widget _fallback(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person_rounded,
        size: 19,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _ImageAttachment extends StatelessWidget {
  const _ImageAttachment({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final isRemote = imagePath.startsWith('http');

    return ClipRRect(
      borderRadius: BorderRadius.circular(11),
      child: SizedBox(
        width: 220,
        height: 170,
        child: isRemote
            ? Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _errorView(context);
                },
              )
            : Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _errorView(context);
                },
              ),
      ),
    );
  }

  Widget _errorView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.broken_image_outlined,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}
