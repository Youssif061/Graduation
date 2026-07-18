part of 'request_cubit.dart';

sealed class RequestState {
  const RequestState();
}

//--------------------------------------------------
// Initial
//--------------------------------------------------

final class RequestInitial extends RequestState {
  const RequestInitial();
}

//--------------------------------------------------
// Loading
//--------------------------------------------------

final class RequestLoading extends RequestState {
  const RequestLoading();
}

//--------------------------------------------------
// Updating
//--------------------------------------------------

final class RequestUpdating extends RequestState {
  const RequestUpdating();
}

//--------------------------------------------------
// Loaded
//--------------------------------------------------

final class RequestLoaded extends RequestState {
  final List<RequestModel> requests;

  const RequestLoaded(
    this.requests,
  );
}

//--------------------------------------------------
// Failure
//--------------------------------------------------

final class RequestFailure extends RequestState {
  final String message;

  const RequestFailure(
    this.message,
  );
}