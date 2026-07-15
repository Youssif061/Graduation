part of 'request_cubit.dart';

sealed class RequestState {
  const RequestState();
}

final class RequestInitial extends RequestState {
  const RequestInitial();
}

final class RequestLoading extends RequestState {
  const RequestLoading();
}

final class RequestLoaded extends RequestState {
  final List<RequestModel> requests;

  const RequestLoaded(this.requests);
}

final class RequestUpdating extends RequestState {
  const RequestUpdating();
}

final class RequestFailure extends RequestState {
  final String message;

  const RequestFailure(this.message);
}