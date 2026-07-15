import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/chat_repository.dart';
import '../../data/fake_chat_repository.dart';
import '../../models/conversation_model.dart';
import 'conversations_state.dart';

class ConversationsCubit extends Cubit<ConversationsState> {
  ConversationsCubit({
    required ChatRepository repository,
    required String currentUserId,
  }) : _repository = repository,
       _currentUserId = currentUserId,
       super(const ConversationsState());

  final ChatRepository _repository;
  final String _currentUserId;

  StreamSubscription<List<ConversationModel>>? _subscription;

  Future<void> loadConversations() async {
    await _subscription?.cancel();

    emit(
      state.copyWith(
        status: ConversationsStatus.loading,
        clearErrorMessage: true,
      ),
    );

    _subscription = _repository
        .watchConversations(currentUserId: _currentUserId)
        .listen(
          (conversations) {
            emit(
              state.copyWith(
                status: ConversationsStatus.success,
                conversations: conversations,
                clearErrorMessage: true,
              ),
            );
          },
          onError: (Object error, StackTrace stackTrace) {
            emit(
              state.copyWith(
                status: ConversationsStatus.failure,
                errorMessage: _errorMessage(error),
              ),
            );
          },
        );
  }

  void changeFilter(ConversationsFilter filter) {
    if (state.filter == filter) {
      return;
    }

    emit(state.copyWith(filter: filter, clearErrorMessage: true));
  }

  Future<void> toggleArchive(ConversationModel conversation) async {
    if (state.updatingConversationId != null) {
      return;
    }

    emit(
      state.copyWith(
        updatingConversationId: conversation.id,
        clearErrorMessage: true,
      ),
    );

    try {
      await _repository.setConversationArchived(
        conversationId: conversation.id,
        currentUserId: _currentUserId,
        archived: !conversation.isArchived,
      );

      emit(
        state.copyWith(
          clearUpdatingConversationId: true,
          clearErrorMessage: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ConversationsStatus.failure,
          clearUpdatingConversationId: true,
          errorMessage: _errorMessage(error),
        ),
      );
    }
  }

  void clearError() {
    emit(
      state.copyWith(
        status: ConversationsStatus.success,
        clearErrorMessage: true,
      ),
    );
  }

  String _errorMessage(Object error) {
    if (error is ChatRepositoryException) {
      return error.message;
    }

    return 'Unable to load conversations.';
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
