import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/functions/validations.dart';
import '../data/firebase_auth_repository.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({FirebaseAuthRepository? repository})
    : _repository = repository ?? FirebaseAuthRepository(),
      super(const ChangePasswordState());

  final FirebaseAuthRepository _repository;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (state.isLoading) {
      return;
    }

    final currentPasswordError = AppValidations.requiredPassword(
      currentPassword,
      fieldName: 'Current password',
    );

    final newPasswordError = AppValidations.newPassword(
      newPassword,
      currentPassword: currentPassword,
    );

    final confirmPasswordError = AppValidations.confirmPassword(
      confirmPassword,
      newPassword: newPassword,
    );

    final validationError =
        currentPasswordError ?? newPasswordError ?? confirmPasswordError;

    if (validationError != null) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: validationError,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ChangePasswordStatus.loading,
        clearErrorMessage: true,
      ),
    );

    try {
      await _repository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      emit(
        state.copyWith(
          status: ChangePasswordStatus.success,
          clearErrorMessage: true,
        ),
      );
    } on AuthRepositoryException catch (error) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: 'Unable to change your password.',
        ),
      );
    }
  }

  void resetStatus() {
    emit(const ChangePasswordState());
  }
}
