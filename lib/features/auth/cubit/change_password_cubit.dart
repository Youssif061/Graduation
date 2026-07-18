import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/functions/validations.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final String? currentPasswordError = AppValidations.requiredPassword(
      currentPassword,
      fieldName: 'Current password',
    );

    final String? newPasswordError = AppValidations.newPassword(
      newPassword,
      currentPassword: currentPassword,
    );

    final String? confirmPasswordError = AppValidations.confirmPassword(
      confirmPassword,
      newPassword: newPassword,
    );

    final String? validationError =
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

    await Future<void>.delayed(const Duration(milliseconds: 700));

    emit(
      state.copyWith(
        status: ChangePasswordStatus.success,
        clearErrorMessage: true,
      ),
    );
  }

  void resetStatus() {
    emit(const ChangePasswordState());
  }
}
