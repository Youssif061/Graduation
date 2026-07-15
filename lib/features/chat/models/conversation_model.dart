import 'package:equatable/equatable.dart';

import 'chat_message_type.dart';

class ConversationModel extends Equatable {
  const ConversationModel({
    required this.id,
    required this.participantIds,
    required this.otherParticipantId,
    required this.otherParticipantName,
    required this.otherParticipantPhotoUrl,
    required this.otherParticipantRole,
    required this.lastMessage,
    required this.lastMessageType,
    required this.lastMessageSenderId,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.isArchived,
    required this.isActive,
    required this.isOnline,
  });

  final String id;
  final List<String> participantIds;

  final String otherParticipantId;
  final String otherParticipantName;
  final String otherParticipantPhotoUrl;
  final String otherParticipantRole;

  final String lastMessage;
  final ChatMessageType lastMessageType;
  final String lastMessageSenderId;
  final DateTime lastMessageAt;

  final int unreadCount;
  final bool isArchived;
  final bool isActive;
  final bool isOnline;

  bool get hasUnreadMessages => unreadCount > 0;

  bool lastMessageIsMine(String currentUserId) {
    return lastMessageSenderId == currentUserId;
  }

  ConversationModel copyWith({
    String? id,
    List<String>? participantIds,
    String? otherParticipantId,
    String? otherParticipantName,
    String? otherParticipantPhotoUrl,
    String? otherParticipantRole,
    String? lastMessage,
    ChatMessageType? lastMessageType,
    String? lastMessageSenderId,
    DateTime? lastMessageAt,
    int? unreadCount,
    bool? isArchived,
    bool? isActive,
    bool? isOnline,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      participantIds: participantIds ?? this.participantIds,
      otherParticipantId: otherParticipantId ?? this.otherParticipantId,
      otherParticipantName: otherParticipantName ?? this.otherParticipantName,
      otherParticipantPhotoUrl:
          otherParticipantPhotoUrl ?? this.otherParticipantPhotoUrl,
      otherParticipantRole: otherParticipantRole ?? this.otherParticipantRole,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      isArchived: isArchived ?? this.isArchived,
      isActive: isActive ?? this.isActive,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  List<Object?> get props => [
    id,
    participantIds,
    otherParticipantId,
    otherParticipantName,
    otherParticipantPhotoUrl,
    otherParticipantRole,
    lastMessage,
    lastMessageType,
    lastMessageSenderId,
    lastMessageAt,
    unreadCount,
    isArchived,
    isActive,
    isOnline,
  ];
}
