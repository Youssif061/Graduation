import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/chat/data/chat_repository.dart';
import 'package:expertisemarket/features/chat/models/chat_message_model.dart';
import 'package:expertisemarket/features/chat/models/chat_message_type.dart';
import 'package:expertisemarket/features/chat/models/conversation_model.dart';
import 'package:expertisemarket/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:expertisemarket/features/chat/presentation/cubit/chat_state.dart';
import 'package:expertisemarket/features/chat/presentation/widgets/chat_header.dart';
import 'package:expertisemarket/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:expertisemarket/features/chat/presentation/widgets/date_separator.dart';
import 'package:expertisemarket/features/chat/presentation/widgets/message_bubble.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.repository,
    required this.currentUserId,
    required this.conversation,
  });

  final ChatRepository repository;
  final String currentUserId;
  final ConversationModel conversation;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const int _maximumAttachmentSize = 10 * 1024 * 1024;

  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  late final ChatCubit _chatCubit;

  int _previousMessageCount = 0;

  @override
  void initState() {
    super.initState();

    _chatCubit = ChatCubit(
      repository: widget.repository,
      conversationId: widget.conversation.id,
      currentUserId: widget.currentUserId,
      otherUserId: widget.conversation.otherParticipantId,
    )..loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _chatCubit.close();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final wasSent = await _chatCubit.sendText(_messageController.text);

    if (!mounted || !wasSent) {
      return;
    }

    _messageController.clear();
    _scrollToBottom();
  }

  Future<void> _pickAttachment() async {
    final result = await FilePicker.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png', 'webp'],
    );

    if (!mounted || result == null || result.files.isEmpty) {
      return;
    }

    final file = result.files.single;
    final filePath = file.path;

    if (filePath == null || filePath.trim().isEmpty) {
      _showMessage('The selected file is unavailable.', isError: true);
      return;
    }

    if (file.size > _maximumAttachmentSize) {
      _showMessage('The attachment must be smaller than 10 MB.', isError: true);
      return;
    }

    final extension = file.extension?.toLowerCase() ?? '';

    final type = {'jpg', 'jpeg', 'png', 'webp'}.contains(extension)
        ? ChatMessageType.image
        : ChatMessageType.file;

    final wasSent = await _chatCubit.sendAttachment(
      type: type,
      filePath: filePath,
      fileName: file.name,
      fileSizeBytes: file.size,
    );

    if (!mounted || !wasSent) {
      return;
    }

    _scrollToBottom();
  }

  Future<void> _openAttachment(ChatMessageModel message) async {
    final attachmentUrl = message.attachmentUrl.trim();

    if (attachmentUrl.isEmpty) {
      _showMessage('The attachment is unavailable.', isError: true);
      return;
    }

    final uri = attachmentUrl.startsWith('http')
        ? Uri.parse(attachmentUrl)
        : Uri.file(attachmentUrl);

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!mounted || opened) {
      return;
    }

    _showMessage('Unable to open this attachment.', isError: true);
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError
              ? Theme.of(context).colorScheme.error
              : AppColors.marketGreenDark,
        ),
      );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  String _dateLabel(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final messageDay = DateTime(date.year, date.month, date.day);

    final difference = today.difference(messageDay).inDays;

    if (difference == 0) {
      return 'Today, ${DateFormat('MMM d').format(date)}';
    }

    if (difference == 1) {
      return 'Yesterday';
    }

    return DateFormat('MMM d, y').format(date);
  }

  bool _shouldShowDateSeparator(List<ChatMessageModel> messages, int index) {
    if (index == 0) {
      return true;
    }

    final current = messages[index].sentAt;
    final previous = messages[index - 1].sentAt;

    return current.year != previous.year ||
        current.month != previous.month ||
        current.day != previous.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatCubit,
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            _showMessage(state.errorMessage!, isError: true);

            _chatCubit.clearError();
          }

          if (state.messages.length != _previousMessageCount) {
            _previousMessageCount = state.messages.length;

            _scrollToBottom();
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: [
                ChatHeader(
                  conversation: widget.conversation,
                  onBackPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(child: _buildMessages(state)),
                ChatInputBar(
                  controller: _messageController,
                  isSending: state.isSending,
                  onSendPressed: _sendMessage,
                  onAttachmentPressed: _pickAttachment,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessages(ChatState state) {
    if (state.isInitialLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.marketGreen),
      );
    }

    if (state.messages.isEmpty) {
      return _EmptyChatView(
        participantName: widget.conversation.otherParticipantName,
      );
    }

    final messages = state.messages;

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 22),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];

        return Column(
          children: [
            if (_shouldShowDateSeparator(messages, index))
              DateSeparator(label: _dateLabel(message.sentAt)),
            MessageBubble(
              message: message,
              currentUserId: widget.currentUserId,
              otherParticipantPhotoUrl:
                  widget.conversation.otherParticipantPhotoUrl,
              onAttachmentPressed: () {
                _openAttachment(message);
              },
            ),
          ],
        );
      },
    );
  }
}

class _EmptyChatView extends StatelessWidget {
  const _EmptyChatView({required this.participantName});

  final String participantName;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.marketGreen.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 33,
                color: AppColors.marketGreen,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Start your conversation',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Send a message to $participantName.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
