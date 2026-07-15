import '../models/chat_message_model.dart';
import '../models/chat_message_type.dart';
import '../models/conversation_model.dart';

abstract class ChatRepository {
  Stream<List<ConversationModel>> watchConversations({
    required String currentUserId,
  });

  Stream<List<ChatMessageModel>> watchMessages({
    required String conversationId,
    int limit = 50,
  });

  Future<String> createOrGetConversation({
    required String currentUserId,
    required String otherUserId,
  });

  Future<void> sendTextMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required String text,
  });

  Future<void> sendAttachmentMessage({
    required String conversationId,
    required String senderId,
    required String receiverId,
    required ChatMessageType type,
    required String filePath,
    required String fileName,
    required int fileSizeBytes,
  });

  Future<void> markConversationAsRead({
    required String conversationId,
    required String currentUserId,
  });

  Future<void> setConversationArchived({
    required String conversationId,
    required String currentUserId,
    required bool archived,
  });
}
