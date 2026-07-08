import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/ServiceProvider/chats/chat_details/presentation/widgets/chat_attachment_card.dart';
import 'package:expertisemarket/features/ServiceProvider/chats/chat_details/presentation/widgets/chat_composer.dart';
import 'package:expertisemarket/features/ServiceProvider/chats/chat_details/presentation/widgets/chat_details_header.dart';
import 'package:expertisemarket/features/ServiceProvider/chats/chat_details/presentation/widgets/chat_message_bubble.dart';
import 'package:flutter/material.dart';

class ServiceProviderChatDetailsPage extends StatefulWidget {
  const ServiceProviderChatDetailsPage({super.key, required this.contactName});

  final String contactName;

  @override
  State<ServiceProviderChatDetailsPage> createState() =>
      _ServiceProviderChatDetailsPageState();
}

class _ServiceProviderChatDetailsPageState
    extends State<ServiceProviderChatDetailsPage> {
  final TextEditingController _messageController = TextEditingController();

  final List<String> _sentMessages = [];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final String message = _messageController.text.trim();

    if (message.isEmpty) {
      return;
    }

    setState(() {
      _sentMessages.add(message);
    });

    _messageController.clear();
  }

  void _showAttachmentFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Attachment picker is UI only for now')),
    );
  }

  void _showDownloadFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download action is UI only for now')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: ChatDetailsHeader(
              name: widget.contactName,
              onBack: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.md,
                AppSizes.md,
                AppSizes.md,
                AppSizes.xxl,
              ),
              children: [
                const _DateSeparator(),
                const SizedBox(height: AppSizes.l),
                const ChatMessageBubble(
                  message:
                      'Hello! I\'ve reviewed your project requirements for the strategic expansion. I believe we can get this moving by early next week. Have you had a chance to look at the initial quote I sent over?',
                  time: '09:42 AM',
                  isMine: false,
                ),
                const ChatMessageBubble(
                  message:
                      'Thanks, David. The timeline looks perfect. I just had one question regarding the compliance section of the quote. Is that bundled into the primary fee?',
                  time: '10:05 AM',
                  isMine: true,
                  isRead: true,
                ),
                ChatMessageBubble(
                  message:
                      'Yes, absolutely. I\'ve updated the breakdown to make that clearer. Take a look at the revised PDF below.',
                  time: '10:12 AM',
                  isMine: false,
                  attachment: ChatAttachmentCard(
                    fileName: 'Revised_Quote_v2.pdf',
                    fileDetails: '1.2 MB • PDF',
                    onDownload: _showDownloadFeedback,
                  ),
                ),
                ..._sentMessages.map((message) {
                  return ChatMessageBubble(
                    message: message,
                    time: 'Now',
                    isMine: true,
                    isRead: true,
                  );
                }),
              ],
            ),
          ),
          ChatComposer(
            controller: _messageController,
            onSend: _sendMessage,
            onAttachmentTap: _showAttachmentFeedback,
          ),
        ],
      ),
    );
  }
}

class _DateSeparator extends StatelessWidget {
  const _DateSeparator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.m,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: AppColors.marketInputBg,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        ),
        child: const Text(
          'Today, Oct 24',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.marketTextSub,
          ),
        ),
      ),
    );
  }
}
