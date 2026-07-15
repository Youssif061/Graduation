import 'package:equatable/equatable.dart';

import '../../models/chat_message_model.dart';

enum ChatStatus { initial, loading, success, failure }

class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.isSending = false,
    this.errorMessage,
  });

  final ChatStatus status;
  final List<ChatMessageModel> messages;
  final bool isSending;
  final String? errorMessage;

  bool get isInitialLoading {
    return status == ChatStatus.loading && messages.isEmpty;
  }

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessageModel>? messages,
    bool? isSending,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, messages, isSending, errorMessage];
}
