part of 'publish_service_cubit.dart';

sealed class PublishServiceState {
  const PublishServiceState();
}

final class PublishServiceInitial extends PublishServiceState {
  const PublishServiceInitial();
}

final class PublishServiceLoading extends PublishServiceState {
  const PublishServiceLoading();
}

final class PublishServiceImagesChanged extends PublishServiceState {
  const PublishServiceImagesChanged();
}

final class PublishServiceSuccess extends PublishServiceState {
  const PublishServiceSuccess();
}

final class PublishServiceFailure extends PublishServiceState {
  final String message;

  const PublishServiceFailure(this.message);
}