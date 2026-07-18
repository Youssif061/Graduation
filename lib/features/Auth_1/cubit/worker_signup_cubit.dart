import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import 'worker_signup_state.dart';

class WorkerSignupCubit extends Cubit<WorkerSignupState> {
  WorkerSignupCubit() : super(const WorkerSignupState());

  void saveImage(String imagePath) {
    emit(state.copyWith(imagePath: imagePath));
  }

  void saveStep1({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(
      state.copyWith(
        name: name,
        email: email,
        phone: phone,
        password: password,
      ),
    );
  }

  void saveStep2({
    required String category,
    required String experience,
    required String nationalId,
  }) {
    emit(
      state.copyWith(
        category: category,
        experience: experience,
        nationalId: nationalId,
      ),
    );
  }

  void saveLocation({required LatLng location, required double radius}) {
    emit(state.copyWith(location: location, radius: radius));
  }

  void clear() {
    emit(const WorkerSignupState());
  }

  void saveSignupMethod(SignupMethod method) {
    emit(state.copyWith(signupMethod: method));
  }
}
