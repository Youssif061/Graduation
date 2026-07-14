import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/firebase_request_repository.dart';
import '../../models/request_urgency.dart';
import '../../models/service_request_model.dart';
import 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit({
    required FirebaseRequestRepository repository,
    ImagePicker? imagePicker,
  }) : _repository = repository,
       _imagePicker = imagePicker ?? ImagePicker(),
       super(const RequestState());

  static const int _maximumPhotoSizeInBytes = 10 * 1024 * 1024;

  final FirebaseRequestRepository _repository;
  final ImagePicker _imagePicker;

  void changeUrgency(RequestUrgency urgency) {
    emit(
      state.copyWith(
        urgency: urgency,
        submissionStatus: RequestSubmissionStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }

  void changeNegotiation(bool value) {
    emit(
      state.copyWith(
        willingToNegotiate: value,
        submissionStatus: RequestSubmissionStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> pickPhoto(ImageSource source) async {
    try {
      final photo = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (photo == null) {
        return;
      }

      final fileSize = await photo.length();

      if (fileSize > _maximumPhotoSizeInBytes) {
        emit(
          state.copyWith(
            submissionStatus: RequestSubmissionStatus.failure,
            errorMessage: 'The selected photo must be smaller than 10 MB.',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          selectedPhoto: photo,
          submissionStatus: RequestSubmissionStatus.initial,
          clearErrorMessage: true,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          submissionStatus: RequestSubmissionStatus.failure,
          errorMessage: 'Unable to select the photo.',
        ),
      );
    }
  }

  void removePhoto() {
    emit(
      state.copyWith(
        clearSelectedPhoto: true,
        submissionStatus: RequestSubmissionStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> submitRequest({
    required String title,
    required String description,
    required String budgetText,
  }) async {
    if (state.isSubmitting) {
      return;
    }

    final normalizedTitle = title.trim();
    final normalizedDescription = description.trim();
    final normalizedBudget = budgetText.trim();

    final budget = normalizedBudget.isEmpty
        ? null
        : double.tryParse(normalizedBudget);

    if (normalizedBudget.isNotEmpty && budget == null) {
      emit(
        state.copyWith(
          submissionStatus: RequestSubmissionStatus.failure,
          errorMessage: 'Enter a valid budget amount.',
        ),
      );
      return;
    }

    if (!state.willingToNegotiate && budget == null) {
      emit(
        state.copyWith(
          submissionStatus: RequestSubmissionStatus.failure,
          errorMessage: 'Enter a budget or enable willing to negotiate.',
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        submissionStatus: RequestSubmissionStatus.loading,
        clearErrorMessage: true,
      ),
    );

    final request = ServiceRequestModel(
      title: normalizedTitle,
      description: normalizedDescription,
      urgency: state.urgency,
      budget: budget,
      willingToNegotiate: state.willingToNegotiate,
    );

    try {
      await _repository.createRequest(
        request: request,
        photo: state.selectedPhoto,
      );

      emit(
        const RequestState(submissionStatus: RequestSubmissionStatus.success),
      );
    } on RequestRepositoryException catch (error) {
      emit(
        state.copyWith(
          submissionStatus: RequestSubmissionStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          submissionStatus: RequestSubmissionStatus.failure,
          errorMessage: 'Unable to post the request.',
        ),
      );
    }
  }

  void clearFeedback() {
    emit(
      state.copyWith(
        submissionStatus: RequestSubmissionStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }
}
