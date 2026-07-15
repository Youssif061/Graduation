import 'package:flutter_svg/flutter_svg.dart';
import 'package:expertisemarket/core/constants/app_icons.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/features/chat/data/chat_repository.dart';
import 'package:expertisemarket/features/chat/data/fake_chat_repository.dart';
import 'package:expertisemarket/features/chat/models/conversation_model.dart';
import 'package:expertisemarket/features/chat/presentation/cubit/conversations_cubit.dart';
import 'package:expertisemarket/features/chat/presentation/cubit/conversations_state.dart';
import 'package:expertisemarket/features/chat/presentation/widgets/chat_app_header.dart';
import 'package:expertisemarket/features/chat/presentation/widgets/conversation_tile.dart';
import 'package:expertisemarket/features/chat/presentation/widgets/conversations_filter_bar.dart';
import 'package:expertisemarket/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({
    super.key,
    this.repository,
    this.currentUserId = 'current-user',
    this.showAppHeader = true,
    this.onConversationPressed,
    this.onNotificationPressed,
  });

  final ChatRepository? repository;
  final String currentUserId;
  final bool showAppHeader;
  final ValueChanged<ConversationModel>? onConversationPressed;
  final VoidCallback? onNotificationPressed;

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  late final ChatRepository _repository;

  @override
  void initState() {
    super.initState();

    _repository = widget.repository ?? FakeChatRepository();
  }

  void _openConversation(ConversationModel conversation) {
    final callback = widget.onConversationPressed;

    if (callback != null) {
      callback(conversation);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ChatPage(
          repository: _repository,
          currentUserId: widget.currentUserId,
          conversation: conversation,
        ),
      ),
    );
  }

  void _showComposeMessage() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text(
            'New conversations will start from an expert profile, request, or order.',
          ),
        ),
      );
  }

  void _showArchiveMessage(ConversationModel conversation) {
    final action = conversation.isArchived ? 'restored' : 'archived';

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${conversation.otherParticipantName} was $action.'),
        ),
      );
  }

  Future<void> _toggleArchive(
    BuildContext context,
    ConversationModel conversation,
  ) async {
    await context.read<ConversationsCubit>().toggleArchive(conversation);

    if (!mounted) {
      return;
    }

    _showArchiveMessage(conversation);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConversationsCubit(
        repository: _repository,
        currentUserId: widget.currentUserId,
      )..loadConversations(),
      child: BlocConsumer<ConversationsCubit, ConversationsState>(
        listener: (context, state) {
          if (state.status == ConversationsStatus.failure &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );

            context.read<ConversationsCubit>().clearError();
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: [
                if (widget.showAppHeader)
                  ChatAppHeader(
                    onNotificationPressed: widget.onNotificationPressed,
                  ),
                Expanded(
                  child: _MessagesBody(
                    state: state,
                    currentUserId: widget.currentUserId,
                    onConversationPressed: _openConversation,
                    onArchivePressed: (conversation) {
                      _toggleArchive(context, conversation);
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _showComposeMessage,
              tooltip: 'New conversation',
              elevation: 4,
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              foregroundColor: Theme.of(context).colorScheme.surface,
              shape: const CircleBorder(),
              child: SvgPicture.asset(
                AppIcons.chatCompose,
                width: 24,
                height: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MessagesBody extends StatelessWidget {
  const _MessagesBody({
    required this.state,
    required this.currentUserId,
    required this.onConversationPressed,
    required this.onArchivePressed,
  });

  final ConversationsState state;
  final String currentUserId;
  final ValueChanged<ConversationModel> onConversationPressed;
  final ValueChanged<ConversationModel> onArchivePressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 22, 16, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Messages',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              if (state.totalUnreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.marketGreenBadge,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${state.totalUnreadCount} New',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.marketGreenDark,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ConversationsFilterBar(
            selectedFilter: state.filter,
            onFilterSelected: (filter) {
              context.read<ConversationsCubit>().changeFilter(filter);
            },
          ),
        ),
        const SizedBox(height: 18),
        Expanded(child: _buildConversationContent(context)),
      ],
    );
  }

  Widget _buildConversationContent(BuildContext context) {
    if (state.isLoading && state.conversations.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.marketGreen),
      );
    }

    final conversations = state.visibleConversations;

    if (conversations.isEmpty) {
      return _EmptyConversationsView(filter: state.filter);
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      itemCount: conversations.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final conversation = conversations[index];

        return ConversationTile(
          conversation: conversation,
          currentUserId: currentUserId,
          isUpdating: state.isUpdating(conversation.id),
          onTap: () {
            onConversationPressed(conversation);
          },
          onArchivePressed: () {
            onArchivePressed(conversation);
          },
        );
      },
    );
  }
}

class _EmptyConversationsView extends StatelessWidget {
  const _EmptyConversationsView({required this.filter});

  final ConversationsFilter filter;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final message = switch (filter) {
      ConversationsFilter.all => 'Your conversations will appear here.',
      ConversationsFilter.active => 'You do not have any active conversations.',
      ConversationsFilter.archived =>
        'You do not have any archived conversations.',
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.marketGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.forum_outlined,
                size: 34,
                color: AppColors.marketGreen,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'No messages yet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
