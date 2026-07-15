import 'dart:async';

import '../models/chat_message_model.dart';
import '../models/chat_message_type.dart';
import '../models/conversation_model.dart';
import 'chat_repository.dart';

class FakeChatRepository implements ChatRepository {
  FakeChatRepository() {
    final now = DateTime.now();

    _conversations = [
      ConversationModel(
        id: 'conversation_alex',
        participantIds: const ['current-user', 'alex-morgan'],
        otherParticipantId: 'alex-morgan',
        otherParticipantName: 'Alex Morgan',
        otherParticipantPhotoUrl: '',
        otherParticipantRole: 'Expert Advisor',
        lastMessage: 'I have attached the revised quotation.',
        lastMessageType: ChatMessageType.file,
        lastMessageSenderId: 'alex-morgan',
        lastMessageAt: now.subtract(const Duration(minutes: 2)),
        unreadCount: 2,
        isArchived: false,
        isActive: true,
        isOnline: true,
      ),
      ConversationModel(
        id: 'conversation_marcus',
        participantIds: const ['current-user', 'marcus-chen'],
        otherParticipantId: 'marcus-chen',
        otherParticipantName: 'Marcus Chen',
        otherParticipantPhotoUrl: '',
        otherParticipantRole: 'Professional Carpenter',
        lastMessage: 'Sure! I will send you the details shortly.',
        lastMessageType: ChatMessageType.text,
        lastMessageSenderId: 'marcus-chen',
        lastMessageAt: now.subtract(const Duration(minutes: 18)),
        unreadCount: 1,
        isArchived: false,
        isActive: true,
        isOnline: true,
      ),
      ConversationModel(
        id: 'conversation_jordan',
        participantIds: const ['current-user', 'jordan-smith'],
        otherParticipantId: 'jordan-smith',
        otherParticipantName: 'Jordan Smith',
        otherParticipantPhotoUrl: '',
        otherParticipantRole: 'Interior Designer',
        lastMessage: 'Thank you for your help.',
        lastMessageType: ChatMessageType.text,
        lastMessageSenderId: 'jordan-smith',
        lastMessageAt: now.subtract(const Duration(hours: 2)),
        unreadCount: 1,
        isArchived: false,
        isActive: true,
        isOnline: false,
      ),
      ConversationModel(
        id: 'conversation_sophia',
        participantIds: const ['current-user', 'sophia-williams'],
        otherParticipantId: 'sophia-williams',
        otherParticipantName: 'Sophia Williams',
        otherParticipantPhotoUrl: '',
        otherParticipantRole: 'Homeowner',
        lastMessage: 'The order was completed successfully.',
        lastMessageType: ChatMessageType.text,
        lastMessageSenderId: 'current-user',
        lastMessageAt: now.subtract(const Duration(days: 1)),
        unreadCount: 0,
        isArchived: true,
        isActive: false,
        isOnline: false,
      ),
    ];

    _messages = {
      'conversation_alex': [
        ChatMessageModel(
          id: 'alex_message_1',
          conversationId: 'conversation_alex',
          senderId: 'alex-morgan',
          receiverId: 'current-user',
          type: ChatMessageType.text,
          text:
              'Hi! I reviewed your request and prepared an updated quotation.',
          attachmentUrl: '',
          attachmentName: '',
          attachmentSizeBytes: 0,
          sentAt: now.subtract(const Duration(minutes: 15)),
          readAt: now.subtract(const Duration(minutes: 14)),
        ),
        ChatMessageModel(
          id: 'alex_message_2',
          conversationId: 'conversation_alex',
          senderId: 'current-user',
          receiverId: 'alex-morgan',
          type: ChatMessageType.text,
          text: 'Great, please send it when you are ready.',
          attachmentUrl: '',
          attachmentName: '',
          attachmentSizeBytes: 0,
          sentAt: now.subtract(const Duration(minutes: 10)),
          readAt: now.subtract(const Duration(minutes: 9)),
        ),
        ChatMessageModel(
          id: 'alex_message_3',
          conversationId: 'conversation_alex',
          senderId: 'alex-morgan',
          receiverId: 'current-user',
          type: ChatMessageType.file,
          text: '',
          attachmentUrl: 'https://example.com/revised-quote.pdf',
          attachmentName: 'Revised_Quote_v2.pdf',
          attachmentSizeBytes: 2400000,
          sentAt: now.subtract(const Duration(minutes: 2)),
        ),
      ],
      'conversation_marcus': [
        ChatMessageModel(
          id: 'marcus_message_1',
          conversationId: 'conversation_marcus',
          senderId: 'marcus-chen',
          receiverId: 'current-user',
          type: ChatMessageType.text,
          text: 'Hello, I can help you with this project.',
          attachmentUrl: '',
          attachmentName: '',
          attachmentSizeBytes: 0,
          sentAt: now.subtract(const Duration(minutes: 30)),
          readAt: now.subtract(const Duration(minutes: 29)),
        ),
        ChatMessageModel(
          id: 'marcus_message_2',
          conversationId: 'conversation_marcus',
          senderId: 'current-user',
          receiverId: 'marcus-chen',
          type: ChatMessageType.text,
          text: 'Could you send me an estimated delivery time?',
          attachmentUrl: '',
          attachmentName: '',
          attachmentSizeBytes: 0,
          sentAt: now.subtract(const Duration(minutes: 25)),
          readAt: now.subtract(const Duration(minutes: 24)),
        ),
        ChatMessageModel(
          id: 'marcus_message_3',
          conversationId: 'conversation_marcus',
          senderId: 'marcus-chen',
          receiverId: 'current-user',
          type: ChatMessageType.text,
          text: 'Sure! I will send you the details shortly.',
          attachmentUrl: '',
          attachmentName: '',
          attachmentSizeBytes: 0,
          sentAt: now.subtract(const Duration(minutes: 18)),
        ),
      ],
      'conversation_jordan': [
        ChatMessageModel(
          id: 'jordan_message_1',
          conversationId: 'conversation_jordan',
          senderId: 'jordan-smith',
          receiverId: 'current-user',
          type: ChatMessageType.text,
          text: 'Thank you for your help.',
          attachmentUrl: '',
          attachmentName: '',
          attachmentSizeBytes: 0,
          sentAt: now.subtract(const Duration(hours: 2)),
        ),
      ],
      'conversation_sophia': [
        ChatMessageModel(
          id: 'sophia_message_1',
          conversationId: 'conversation_sophia',
          senderId: 'current-user',
          receiverId: 'sophia-williams',
          type: ChatMessageType.text,
          text: 'The order was completed successfully.',
          attachmentUrl: '',
          attachmentName: '',
          attachmentSizeBytes: 0,
          sentAt: now.subtract(const Duration(days: 1)),
          readAt: now.subtract(const Duration(hours: 23)),
        ),
      ],
    };
  }

  final StreamController<List<ConversationModel>> _conversationsController =
      StreamController<List<ConversationModel>>.broadcast();

  final Map<String, StreamController<List<ChatMessageModel>>>
  _messageControllers = {};

  late List<ConversationModel> _conversations;
  late Map<String, List<ChatMessageModel>> _messages;

  @override
  Stream<List<ConversationModel>> watchConversations({
    required String currentUserId,
  }) async* {
    yield List<ConversationModel>.unmodifiable(_conversations);
    yield* _conversationsController.stream;
  }

  @override
  Stream<List<ChatMessageModel>> watchMessages({
    required String conversationId,
    int limit = 50,
  }) async* {
    final messages = _messages[conversationId] ?? [];

    yield List<ChatMessageModel>.unmodifiable(
      messages.length <= limit
          ? messages
          : messages.sublist(messages.length - limit),
    );

    final controller = _messageControllers.putIfAbsent(
      conversationId,
      () => StreamController<List<ChatMessageModel>>.broadcast(),
    );

    yield* controller.stream;
  }

  @override
  Future<String> createOrGetConversation({
    required String currentUserId,
    required String otherUserId,
  }) async {
    for (final conversation in _conversations) {
      final hasCurrentUser = conversation.participantIds.contains(
        currentUserId,
      );

      final hasOtherUser = conversation.participantIds.contains(otherUserId);

      if (hasCurrentUser && hasOtherUser) {
        return conversation.id;
      }
    }

    final conversationId =
        'conversation_${DateTime.now().microsecondsSinceEpoch}';

    final conversation = ConversationModel(
      id: conversationId,
      participantIds: [currentUserId, otherUserId],
      otherParticipantId: otherUserId,
      otherParticipantName: 'New Contact',
      otherParticipantPhotoUrl: '',
      otherParticipantRole: 'ExpertiseMarket Member',
      lastMessage: '',
      lastMessageType: ChatMessageType.text,
      lastMessageSenderId: '',
      lastMessageAt: DateTime.now(),
      unreadCount: 0,
      isArchived: false,
      isActive: true,
      isOnline: false,
    );

    _conversations = [conversation, ..._conversations];

    _messages[conversationId] = [];

    _emitConversations();

    return conversationId;
  }

  @override
  Future<void> sendTextMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final normalizedText = text.trim();

    if (normalizedText.isEmpty) {
      throw const ChatRepositoryException('Message cannot be empty.');
    }

    final message = ChatMessageModel(
      id: 'message_${DateTime.now().microsecondsSinceEpoch}',
      conversationId: conversationId,
      senderId: senderId,
      receiverId: receiverId,
      type: ChatMessageType.text,
      text: normalizedText,
      attachmentUrl: '',
      attachmentName: '',
      attachmentSizeBytes: 0,
      sentAt: DateTime.now(),
    );

    final messages = _messages.putIfAbsent(conversationId, () => []);

    messages.add(message);

    _updateConversationFromMessage(message);
    _emitMessages(conversationId);
    _emitConversations();
  }

  @override
  Future<void> sendAttachmentMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required ChatMessageType type,
    required String filePath,
    required String fileName,
    required int fileSizeBytes,
  }) async {
    if (filePath.trim().isEmpty) {
      throw const ChatRepositoryException(
        'The selected attachment is unavailable.',
      );
    }

    final message = ChatMessageModel(
      id: 'message_${DateTime.now().microsecondsSinceEpoch}',
      conversationId: conversationId,
      senderId: senderId,
      receiverId: receiverId,
      type: type,
      text: '',
      attachmentUrl: filePath,
      attachmentName: fileName,
      attachmentSizeBytes: fileSizeBytes,
      sentAt: DateTime.now(),
    );

    final messages = _messages.putIfAbsent(conversationId, () => []);

    messages.add(message);

    _updateConversationFromMessage(message);
    _emitMessages(conversationId);
    _emitConversations();
  }

  @override
  Future<void> markConversationAsRead({
    required String conversationId,
    required String currentUserId,
  }) async {
    final now = DateTime.now();
    final messages = _messages[conversationId] ?? [];

    _messages[conversationId] = messages.map((message) {
      final shouldMarkAsRead =
          message.receiverId == currentUserId && message.readAt == null;

      return shouldMarkAsRead ? message.copyWith(readAt: now) : message;
    }).toList();

    final conversationIndex = _conversations.indexWhere(
      (conversation) => conversation.id == conversationId,
    );

    if (conversationIndex != -1) {
      _conversations[conversationIndex] = _conversations[conversationIndex]
          .copyWith(unreadCount: 0);
    }

    _emitMessages(conversationId);
    _emitConversations();
  }

  @override
  Future<void> setConversationArchived({
    required String conversationId,
    required String currentUserId,
    required bool archived,
  }) async {
    final conversationIndex = _conversations.indexWhere(
      (conversation) => conversation.id == conversationId,
    );

    if (conversationIndex == -1) {
      throw const ChatRepositoryException('Conversation was not found.');
    }

    _conversations[conversationIndex] = _conversations[conversationIndex]
        .copyWith(isArchived: archived, isActive: !archived);

    _emitConversations();
  }

  void _updateConversationFromMessage(ChatMessageModel message) {
    final conversationIndex = _conversations.indexWhere(
      (conversation) => conversation.id == message.conversationId,
    );

    if (conversationIndex == -1) {
      return;
    }

    final preview = switch (message.type) {
      ChatMessageType.text => message.text,
      ChatMessageType.image => 'Photo',
      ChatMessageType.file =>
        message.attachmentName.isEmpty
            ? 'File attachment'
            : message.attachmentName,
    };

    _conversations[conversationIndex] = _conversations[conversationIndex]
        .copyWith(
          lastMessage: preview,
          lastMessageType: message.type,
          lastMessageSenderId: message.senderId,
          lastMessageAt: message.sentAt,
          isArchived: false,
          isActive: true,
        );

    _conversations.sort(
      (first, second) => second.lastMessageAt.compareTo(first.lastMessageAt),
    );
  }

  void _emitConversations() {
    if (_conversationsController.isClosed) {
      return;
    }

    _conversationsController.add(
      List<ConversationModel>.unmodifiable(_conversations),
    );
  }

  void _emitMessages(String conversationId) {
    final controller = _messageControllers[conversationId];

    if (controller == null || controller.isClosed) {
      return;
    }

    controller.add(
      List<ChatMessageModel>.unmodifiable(_messages[conversationId] ?? []),
    );
  }
}

class ChatRepositoryException implements Exception {
  const ChatRepositoryException(this.message);

  final String message;

  @override
  String toString() => message;
}
