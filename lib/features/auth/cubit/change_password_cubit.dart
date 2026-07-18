import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'no-current-user',
          message: 'User is not currently authenticated.',
        );
      }

      final email = user.email;
      if (email == null) {
        throw FirebaseAuthException(
          code: 'no-email',
          message: 'User email is not found.',
        );
      }

      // Reauthenticate user before changing password
      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      emit(
        state.copyWith(
          status: ChangePasswordStatus.success,
          clearErrorMessage: true,
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: e.message ?? 'Authentication error occurred.',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void resetStatus() {
    emit(const ChangePasswordState());
  }
}
