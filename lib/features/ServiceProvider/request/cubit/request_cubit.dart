import 'package:expertisemarket/features/ServiceProvider/request/model/request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit() : super(const RequestInitial());

  final List<RequestModel> _requests = [];

  List<RequestModel> get requests => List.unmodifiable(_requests);

  Future<void> loadRequests() async {
    try {
      emit(const RequestLoading());

      /// سيتم جلب البيانات من Firebase لاحقاً
      await Future.delayed(const Duration(seconds: 1));

      emit(RequestLoaded(List.from(_requests)));
    } catch (e) {
      emit(RequestFailure(e.toString()));
    }
  }

  Future<void> refreshRequests() async {
    await loadRequests();
  }

  Future<void> acceptRequest(String requestId) async {
    try {
      emit(const RequestUpdating());

      final index = _requests.indexWhere((e) => e.id == requestId);

      if (index != -1) {
        _requests[index] = _requests[index].copyWith(
          status: "In Progress",
        );
      }

      emit(RequestLoaded(List.from(_requests)));
    } catch (e) {
      emit(RequestFailure(e.toString()));
    }
  }

  Future<void> rejectRequest(String requestId) async {
    try {
      emit(const RequestUpdating());

      _requests.removeWhere((e) => e.id == requestId);

      emit(RequestLoaded(List.from(_requests)));
    } catch (e) {
      emit(RequestFailure(e.toString()));
    }
  }
}