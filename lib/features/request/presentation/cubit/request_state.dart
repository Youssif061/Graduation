import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/request_urgency.dart';

enum RequestSubmissionStatus { initial, loading, success, failure }

class RequestState extends Equatable {
  const RequestState({
    this.urgency = RequestUrgency.medium,
    this.willingToNegotiate = true,
    this.selectedPhoto,
    this.submissionStatus = RequestSubmissionStatus.initial,
    this.errorMessage,
  });

  final RequestUrgency urgency;
  final bool willingToNegotiate;
  final XFile? selectedPhoto;
  final RequestSubmissionStatus submissionStatus;
  final String? errorMessage;

  bool get isSubmitting => submissionStatus == RequestSubmissionStatus.loading;

  RequestState copyWith({
    RequestUrgency? urgency,
    bool? willingToNegotiate,
    XFile? selectedPhoto,
    bool clearSelectedPhoto = false,
    RequestSubmissionStatus? submissionStatus,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return RequestState(
      urgency: urgency ?? this.urgency,
      willingToNegotiate: willingToNegotiate ?? this.willingToNegotiate,
      selectedPhoto: clearSelectedPhoto
          ? null
          : selectedPhoto ?? this.selectedPhoto,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    urgency,
    willingToNegotiate,
    selectedPhoto?.path,
    submissionStatus,
    errorMessage,
  ];
}
