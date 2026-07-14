import 'package:equatable/equatable.dart';

import '../../models/user_profile_model.dart';

enum ProfileStatus {
  initial,
  loading,
  loaded,
  updating,
  success,
  failure,
  signingOut,
  signedOut,
}

enum ProfileSuccessAction { none, nameUpdated, photoUpdated, photoDeleted }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.successAction = ProfileSuccessAction.none,
    this.errorMessage,
  });

  final ProfileStatus status;
  final UserProfileModel? profile;
  final ProfileSuccessAction successAction;
  final String? errorMessage;

  bool get isInitialLoading =>
      status == ProfileStatus.loading && profile == null;

  bool get isUpdating => status == ProfileStatus.updating;

  bool get isSigningOut => status == ProfileStatus.signingOut;

  bool get isBusy => isInitialLoading || isUpdating || isSigningOut;

  ProfileState copyWith({
    ProfileStatus? status,
    UserProfileModel? profile,
    bool clearProfile = false,
    ProfileSuccessAction? successAction,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: clearProfile ? null : profile ?? this.profile,
      successAction: successAction ?? this.successAction,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, successAction, errorMessage];
}
