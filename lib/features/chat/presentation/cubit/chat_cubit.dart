import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/chat_repository.dart';
import '../../data/fake_chat_repository.dart';
import '../../models/chat_message_model.dart';
import '../../models/chat_message_type.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required ChatRepository repository,
    required String conversationId,
    required String currentUserId,
    required String otherUserId,
  }) : _repository = repository,
       _conversationId = conversationId,
       _currentUserId = currentUserId,
       _otherUserId = otherUserId,
       super(const ChatState());

  final ChatRepository _repository;
  final String _conversationId;
  final String _currentUserId;
  final String _otherUserId;

  StreamSubscription<List<ChatMessageModel>>? _subscription;

  String get currentUserId => _currentUserId;

  Future<void> loadMessages() async {
    await _subscription?.cancel();

    emit(state.copyWith(status: ChatStatus.loading, clearErrorMessage: true));

    _subscription = _repository
        .watchMessages(conversationId: _conversationId)
        .listen(
          (messages) {
            final sortedMessages = [...messages]
              ..sort((first, second) => first.sentAt.compareTo(second.sentAt));

            emit(
              state.copyWith(
                status: ChatStatus.success,
                messages: sortedMessages,
                clearErrorMessage: true,
              ),
            );
          },
          onError: (Object error, StackTrace stackTrace) {
            emit(
              state.copyWith(
                status: ChatStatus.failure,
                errorMessage: _errorMessage(error),
              ),
            );
          },
        );

    try {
      await _repository.markConversationAsRead(
        conversationId: _conversationId,
        currentUserId: _currentUserId,
      );
    } catch (_) {
      // Reading messages must not prevent opening the conversation.
    }
  }

  Future<bool> sendText(String text) async {
    final normalizedText = text.trim();

    if (normalizedText.isEmpty) {
      emit(
        state.copyWith(
          status: ChatStatus.failure,
          errorMessage: 'Type a message before sending.',
        ),
      );

      return false;
    }

    if (state.isSending) {
      return false;
    }

    emit(state.copyWith(isSending: true, clearErrorMessage: true));

    try {
      await _repository.sendTextMessage(
        conversationId: _conversationId,
        senderId: _currentUserId,
        receiverId: _otherUserId,
        text: normalizedText,
      );

      emit(
        state.copyWith(
          status: ChatStatus.success,
          isSending: false,
          clearErrorMessage: true,
        ),
      );

      return true;
    } catch (error) {
      emit(
        state.copyWith(
          status: ChatStatus.failure,
          isSending: false,
          errorMessage: _errorMessage(error),
        ),
      );

      return false;
    }
  }

  Future<bool> sendAttachment({
    required ChatMessageType type,
    required String filePath,
    required String fileName,
    required int fileSizeBytes,
  }) async {
    if (state.isSending) {
      return false;
    }

    emit(state.copyWith(isSending: true, clearErrorMessage: true));

    try {
      await _repository.sendAttachmentMessage(
        conversationId: _conversationId,
        senderId: _currentUserId,
        receiverId: _otherUserId,
        type: type,
        filePath: filePath,
        fileName: fileName,
        fileSizeBytes: fileSizeBytes,
      );

      emit(
        state.copyWith(
          status: ChatStatus.success,
          isSending: false,
          clearErrorMessage: true,
        ),
      );

      return true;
    } catch (error) {
      emit(
        state.copyWith(
          status: ChatStatus.failure,
          isSending: false,
          errorMessage: _errorMessage(error),
        ),
      );

      return false;
    }
  }

  void clearError() {
    emit(state.copyWith(status: ChatStatus.success, clearErrorMessage: true));
  }

  String _errorMessage(Object error) {
    if (error is ChatRepositoryException) {
      return error.message;
    }

    return 'Unable to complete the chat action.';
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
