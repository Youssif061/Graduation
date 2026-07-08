import 'package:expertisemarket/core/constants/app_sizes.dart';
import 'package:expertisemarket/core/styles/colors.dart';
import 'package:expertisemarket/core/styles/text_styles.dart';
import 'package:expertisemarket/features/ServiceProvider/chats/conversations/presentation/widgets/conversation_card.dart';
import 'package:expertisemarket/features/ServiceProvider/chats/conversations/presentation/widgets/conversations_filter_bar.dart';
import 'package:expertisemarket/features/ServiceProvider/chats/chat_details/presentation/pages/service_provider_chat_details_page.dart';
import 'package:flutter/material.dart';

class ServiceProviderConversationsPage extends StatefulWidget {
  const ServiceProviderConversationsPage({super.key});

  @override
  State<ServiceProviderConversationsPage> createState() =>
      _ServiceProviderConversationsPageState();
}

class _ServiceProviderConversationsPageState
    extends State<ServiceProviderConversationsPage> {
  int _selectedFilterIndex = 0;

  static const List<_ConversationData> _conversations = [
    _ConversationData(
      name: 'Marcus Chen',
      message: 'I\'ve reviewed the project scope and can start on Monday...',
      time: '2m ago',
      unreadCount: 2,
      isOnline: true,
      isUnread: true,
    ),
    _ConversationData(
      name: 'David Miller',
      message:
          'Great! I\'ll send over the final contract by the end of the day.',
      time: '1h ago',
    ),
    _ConversationData(
      name: 'Jordan Smith',
      message: 'Can we jump on a quick 10-minute discovery call?',
      time: '4h ago',
      unreadCount: 1,
      isOnline: true,
      isUnread: true,
    ),
    _ConversationData(
      name: 'Marcus Thorne',
      message:
          'The report has been uploaded to your dashboard. Let me know if you need any adjustments.',
      time: 'Yesterday',
      isArchived: true,
    ),
    _ConversationData(
      name: 'James Wilson',
      message: 'I\'ve confirmed our appointment for Thursday at 10 AM.',
      time: '2 days ago',
      isArchived: true,
    ),
  ];

  List<_ConversationData> get _visibleConversations {
    switch (_selectedFilterIndex) {
      case 1:
        return _conversations
            .where((conversation) => conversation.isActive)
            .toList();

      case 2:
        return _conversations
            .where((conversation) => conversation.isArchived)
            .toList();

      default:
        return _conversations;
    }
  }

  void _openConversation(_ConversationData conversation) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ServiceProviderChatDetailsPage(
          contactName: conversation.name,
        ),
      ),
    );
  }

  void _startNewConversation() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('New conversation UI')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.marketBg,
      floatingActionButton: FloatingActionButton(
        onPressed: _startNewConversation,
        backgroundColor: AppColors.marketText,
        foregroundColor: Colors.white,
        child: const Icon(Icons.edit_outlined),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(AppSizes.md, 0, AppSizes.md, 104),
          children: [
            const _ConversationsHeader(),
            const SizedBox(height: AppSizes.m),
            const _MessagesTitleRow(),
            const SizedBox(height: AppSizes.l),
            ConversationsFilterBar(
              selectedIndex: _selectedFilterIndex,
              onSelected: (index) {
                setState(() {
                  _selectedFilterIndex = index;
                });
              },
            ),
            const SizedBox(height: AppSizes.xl),
            ..._visibleConversations.map((conversation) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.md),
                child: ConversationCard(
                  name: conversation.name,
                  message: conversation.message,
                  time: conversation.time,
                  unreadCount: conversation.unreadCount,
                  isOnline: conversation.isOnline,
                  isUnread: conversation.isUnread,
                  onTap: () => _openConversation(conversation),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ConversationsHeader extends StatelessWidget {
  const _ConversationsHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.marketCard,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.marketBorder),
            ),
          ),
          const SizedBox(width: AppSizes.m),
          Text(
            'ExpertiseMarket',
            style: MarketTextStyles.sectionTitle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.marketText,
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagesTitleRow extends StatelessWidget {
  const _MessagesTitleRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Messages',
            style: MarketTextStyles.sectionTitle.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.marketText,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.m,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF75F0A8),
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          ),
          child: const Text(
            '4 New',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF087A42),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConversationData {
  const _ConversationData({
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isUnread = false,
    this.isArchived = false,
  });

  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isUnread;
  final bool isArchived;

  bool get isActive => !isArchived;
}
