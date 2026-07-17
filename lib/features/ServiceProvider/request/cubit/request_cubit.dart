import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/request_model.dart';
import '../repository/request_repository.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit({
    required RequestRepository repository,
  })  : _repository = repository,
        super(const RequestInitial());

  final RequestRepository _repository;

  final List<RequestModel> _requests = [];

  List<RequestModel> get requests =>
      List.unmodifiable(_requests);

  //--------------------------------------------------
  // Load Requests
  //--------------------------------------------------

  Future<void> loadRequests() async {
    try {
      emit(const RequestLoading());

      final result =
          await _repository.getRequests();

      _requests
        ..clear()
        ..addAll(result);

      emit(
        RequestLoaded(
          List.unmodifiable(_requests),
        ),
      );
    } catch (e) {
      emit(
        RequestFailure(
          e.toString(),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Refresh
  //--------------------------------------------------

  Future<void> refreshRequests() async {
    await loadRequests();
  }

  //--------------------------------------------------
  // Accept Request
  //--------------------------------------------------

  Future<void> acceptRequest(
    String requestId,
  ) async {
    try {
      emit(const RequestUpdating());

      await _repository.acceptRequest(
        requestId,
      );

      final index = _requests.indexWhere(
        (e) => e.id == requestId,
      );

      if (index != -1) {
        _requests[index] =
            _requests[index].copyWith(
          status: 'In Progress',
        );
      }

      emit(
        RequestLoaded(
          List.unmodifiable(_requests),
        ),
      );
    } catch (e) {
      emit(
        RequestFailure(
          e.toString(),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Reject Request
  //--------------------------------------------------

  Future<void> rejectRequest(
    String requestId,
  ) async {
    try {
      emit(const RequestUpdating());

      await _repository.rejectRequest(
        requestId,
      );

      _requests.removeWhere(
        (e) => e.id == requestId,
      );

      emit(
        RequestLoaded(
          List.unmodifiable(_requests),
        ),
      );
    } catch (e) {
      emit(
        RequestFailure(
          e.toString(),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Update Proposal Price
  //--------------------------------------------------

  Future<void> updateProposalPrice({
    required String requestId,
    required double price,
  }) async {
    try {
      emit(const RequestUpdating());

      await _repository
          .updateProposalPrice(
        requestId: requestId,
        price: price,
      );

      final index = _requests.indexWhere(
        (e) => e.id == requestId,
      );

      if (index != -1) {
        _requests[index] =
            _requests[index].copyWith(
          price: price,
        );
      }

      emit(
        RequestLoaded(
          List.unmodifiable(_requests),
        ),
      );
    } catch (e) {
      emit(
        RequestFailure(
          e.toString(),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Update Status
  //--------------------------------------------------

  Future<void> updateRequestStatus({
    required String requestId,
    required String status,
  }) async {
    try {
      emit(const RequestUpdating());

      await _repository.updateRequestStatus(
        requestId: requestId,
        status: status,
      );

      final index = _requests.indexWhere(
        (e) => e.id == requestId,
      );

      if (index != -1) {
        _requests[index] =
            _requests[index].copyWith(
          status: status,
        );
      }

      emit(
        RequestLoaded(
          List.unmodifiable(_requests),
        ),
      );
    } catch (e) {
      emit(
        RequestFailure(
          e.toString(),
        ),
      );
    }
  }

  //--------------------------------------------------
  // Get Request
  //--------------------------------------------------

  RequestModel? getRequestById(
    String id,
  ) {
    try {
      return _requests.firstWhere(
        (e) => e.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}