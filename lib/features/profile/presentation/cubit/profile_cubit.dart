import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/firebase_profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required FirebaseProfileRepository repository,
    ImagePicker? imagePicker,
  }) : _repository = repository,
       _imagePicker = imagePicker ?? ImagePicker(),
       super(const ProfileState());

  static const int _maximumPhotoSizeInBytes = 10 * 1024 * 1024;

  final FirebaseProfileRepository _repository;
  final ImagePicker _imagePicker;

  Future<void> loadProfile() async {
    if (state.isBusy) {
      return;
    }

    emit(
      state.copyWith(
        status: ProfileStatus.loading,
        successAction: ProfileSuccessAction.none,
        clearErrorMessage: true,
      ),
    );

    try {
      final profile = await _repository.loadProfile();

      emit(
        state.copyWith(
          status: ProfileStatus.loaded,
          profile: profile,
          successAction: ProfileSuccessAction.none,
          clearErrorMessage: true,
        ),
      );
    } on ProfileRepositoryException catch (error) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: error.message,
          successAction: ProfileSuccessAction.none,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: 'Unable to load the profile.',
          successAction: ProfileSuccessAction.none,
        ),
      );
    }
  }

  Future<void> updateFullName(String fullName) async {
    if (state.isBusy) {
      return;
    }

    final normalizedName = fullName.trim();

    if (normalizedName.isEmpty) {
      _emitValidationFailure('Please enter your full name.');
      return;
    }

    if (normalizedName.length < 2) {
      _emitValidationFailure('Full name must contain at least 2 characters.');
      return;
    }

    if (normalizedName.length > 60) {
      _emitValidationFailure('Full name must not exceed 60 characters.');
      return;
    }

    emit(
      state.copyWith(
        status: ProfileStatus.updating,
        successAction: ProfileSuccessAction.none,
        clearErrorMessage: true,
      ),
    );

    try {
      final profile = await _repository.updateFullName(normalizedName);

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          successAction: ProfileSuccessAction.nameUpdated,
          clearErrorMessage: true,
        ),
      );
    } on ProfileRepositoryException catch (error) {
      _emitRepositoryFailure(error);
    } catch (_) {
      _emitValidationFailure('Unable to update your full name.');
    }
  }

  Future<void> changePhoto(ImageSource source) async {
    if (state.isBusy) {
      return;
    }

    try {
      final photo = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (photo == null) {
        return;
      }

      final photoSize = await photo.length();

      if (photoSize > _maximumPhotoSizeInBytes) {
        _emitValidationFailure(
          'The selected photo must be smaller than 10 MB.',
        );
        return;
      }

      emit(
        state.copyWith(
          status: ProfileStatus.updating,
          successAction: ProfileSuccessAction.none,
          clearErrorMessage: true,
        ),
      );

      final profile = await _repository.updateProfilePhoto(photo);

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          successAction: ProfileSuccessAction.photoUpdated,
          clearErrorMessage: true,
        ),
      );
    } on ProfileRepositoryException catch (error) {
      _emitRepositoryFailure(error);
    } catch (_) {
      _emitValidationFailure('Unable to select or upload the profile photo.');
    }
  }

  Future<void> deletePhoto() async {
    if (state.isBusy) {
      return;
    }

    emit(
      state.copyWith(
        status: ProfileStatus.updating,
        successAction: ProfileSuccessAction.none,
        clearErrorMessage: true,
      ),
    );

    try {
      final profile = await _repository.deleteProfilePhoto();

      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          successAction: ProfileSuccessAction.photoDeleted,
          clearErrorMessage: true,
        ),
      );
    } on ProfileRepositoryException catch (error) {
      _emitRepositoryFailure(error);
    } catch (_) {
      _emitValidationFailure('Unable to delete the profile photo.');
    }
  }

  Future<void> logout() async {
    if (state.isBusy) {
      return;
    }

    emit(
      state.copyWith(
        status: ProfileStatus.signingOut,
        successAction: ProfileSuccessAction.none,
        clearErrorMessage: true,
      ),
    );

    try {
      await _repository.signOut();

      emit(
        state.copyWith(
          status: ProfileStatus.signedOut,
          clearProfile: true,
          successAction: ProfileSuccessAction.none,
          clearErrorMessage: true,
        ),
      );
    } on ProfileRepositoryException catch (error) {
      _emitRepositoryFailure(error);
    } catch (_) {
      _emitValidationFailure('Unable to log out. Please try again.');
    }
  }

  void clearFeedback() {
    emit(
      state.copyWith(
        status: state.profile == null
            ? ProfileStatus.initial
            : ProfileStatus.loaded,
        successAction: ProfileSuccessAction.none,
        clearErrorMessage: true,
      ),
    );
  }

  void _emitValidationFailure(String message) {
    emit(
      state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: message,
        successAction: ProfileSuccessAction.none,
      ),
    );
  }

  void _emitRepositoryFailure(ProfileRepositoryException error) {
    emit(
      state.copyWith(
        status: ProfileStatus.failure,
        errorMessage: error.message,
        successAction: ProfileSuccessAction.none,
      ),
    );
  }
}
