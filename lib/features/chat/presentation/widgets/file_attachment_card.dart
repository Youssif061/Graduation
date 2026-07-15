import 'package:expertisemarket/core/constants/app_icons.dart';
import 'package:expertisemarket/features/chat/models/chat_message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FileAttachmentCard extends StatelessWidget {
  const FileAttachmentCard({
    super.key,
    required this.message,
    required this.isMine,
    required this.onPressed,
  });

  final ChatMessageModel message;
  final bool isMine;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final textColor = isMine ? Colors.white : colorScheme.onSurface;
    final secondaryTextColor = isMine
        ? Colors.white70
        : colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 255,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMine
              ? Colors.white.withValues(alpha: 0.10)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isMine
                ? Colors.white.withValues(alpha: 0.14)
                : colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 43,
              height: 43,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(AppIcons.chatPdf),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.attachmentName.isEmpty
                        ? 'Document.pdf'
                        : message.attachmentName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_formatBytes(message.attachmentSizeBytes)} • PDF',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(
              AppIcons.chatDownload,
              width: 21,
              height: 21,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) {
      return '0 KB';
    }

    const kilobyte = 1024;
    const megabyte = kilobyte * 1024;

    if (bytes >= megabyte) {
      return '${(bytes / megabyte).toStringAsFixed(1)} MB';
    }

    return '${(bytes / kilobyte).ceil()} KB';
  }
}
