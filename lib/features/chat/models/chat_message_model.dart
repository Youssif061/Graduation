import 'package:equatable/equatable.dart';

import 'chat_message_type.dart';

class ChatMessageModel extends Equatable {
  const ChatMessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.type,
    required this.text,
    required this.attachmentUrl,
    required this.attachmentName,
    required this.attachmentSizeBytes,
    required this.sentAt,
    this.readAt,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final ChatMessageType type;
  final String text;
  final String attachmentUrl;
  final String attachmentName;
  final int attachmentSizeBytes;
  final DateTime sentAt;
  final DateTime? readAt;

  bool get isRead => readAt != null;

  bool get hasAttachment {
    return attachmentUrl.trim().isNotEmpty;
  }

  bool isMine(String currentUserId) {
    return senderId == currentUserId;
  }

  ChatMessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? receiverId,
    ChatMessageType? type,
    String? text,
    String? attachmentUrl,
    String? attachmentName,
    int? attachmentSizeBytes,
    DateTime? sentAt,
    DateTime? readAt,
    bool clearReadAt = false,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      text: text ?? this.text,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentSizeBytes: attachmentSizeBytes ?? this.attachmentSizeBytes,
      sentAt: sentAt ?? this.sentAt,
      readAt: clearReadAt ? null : readAt ?? this.readAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    conversationId,
    senderId,
    receiverId,
    type,
    text,
    attachmentUrl,
    attachmentName,
    attachmentSizeBytes,
    sentAt,
    readAt,
  ];
}
