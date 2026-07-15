import 'package:equatable/equatable.dart';

import '../../models/conversation_model.dart';

enum ConversationsStatus { initial, loading, success, failure }

enum ConversationsFilter { all, active, archived }

class ConversationsState extends Equatable {
  const ConversationsState({
    this.status = ConversationsStatus.initial,
    this.filter = ConversationsFilter.all,
    this.conversations = const [],
    this.updatingConversationId,
    this.errorMessage,
  });

  final ConversationsStatus status;
  final ConversationsFilter filter;
  final List<ConversationModel> conversations;
  final String? updatingConversationId;
  final String? errorMessage;

  bool get isLoading => status == ConversationsStatus.loading;

  List<ConversationModel> get visibleConversations {
    switch (filter) {
      case ConversationsFilter.all:
        return conversations;

      case ConversationsFilter.active:
        return conversations
            .where(
              (conversation) =>
                  conversation.isActive && !conversation.isArchived,
            )
            .toList();

      case ConversationsFilter.archived:
        return conversations
            .where((conversation) => conversation.isArchived)
            .toList();
    }
  }

  int get totalUnreadCount {
    return conversations.fold<int>(
      0,
      (total, conversation) => total + conversation.unreadCount,
    );
  }

  bool isUpdating(String conversationId) {
    return updatingConversationId == conversationId;
  }

  ConversationsState copyWith({
    ConversationsStatus? status,
    ConversationsFilter? filter,
    List<ConversationModel>? conversations,
    String? updatingConversationId,
    bool clearUpdatingConversationId = false,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ConversationsState(
      status: status ?? this.status,
      filter: filter ?? this.filter,
      conversations: conversations ?? this.conversations,
      updatingConversationId: clearUpdatingConversationId
          ? null
          : updatingConversationId ?? this.updatingConversationId,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    filter,
    conversations,
    updatingConversationId,
    errorMessage,
  ];
}
