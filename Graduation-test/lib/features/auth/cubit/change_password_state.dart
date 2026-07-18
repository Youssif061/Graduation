import 'package:equatable/equatable.dart';

enum ChangePasswordStatus { initial, loading, success, failure }

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = ChangePasswordStatus.initial,
    this.errorMessage,
  });

  final ChangePasswordStatus status;
  final String? errorMessage;

  bool get isLoading => status == ChangePasswordStatus.loading;

  bool get isSuccess => status == ChangePasswordStatus.success;

  bool get isFailure => status == ChangePasswordStatus.failure;

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}