import 'package:latlong2/latlong.dart';

enum SignupMethod { email, google, apple }

class WorkerSignupState {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String uid;
  final String imagePath;
  final String category;
  final String experience;
  final String nationalId;

  final LatLng? location;
  final double radius;
  final SignupMethod signupMethod;
  final bool loading;
  final String? error;

  const WorkerSignupState({
    this.name = '',
    this.uid = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.category = '',
    this.experience = '',
    this.nationalId = '',
    this.location,
    this.radius = 1000,
    this.loading = false,
    this.error,
    this.imagePath = '',
    this.signupMethod = SignupMethod.email,
  });

  WorkerSignupState copyWith({
    String? name,
    String? email,
    String? phone,
    String? uid,
    String? password,
    String? category,
    String? experience,
    String? nationalId,
    LatLng? location,
    double? radius,
    bool? loading,
    String? error,
    String? imagePath,
    SignupMethod? signupMethod,
    bool clearError = false,
  }) {
    return WorkerSignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
      password: password ?? this.password,
      category: category ?? this.category,
      imagePath: imagePath ?? this.imagePath,
      experience: experience ?? this.experience,
      nationalId: nationalId ?? this.nationalId,
      location: location ?? this.location,
      radius: radius ?? this.radius,
      loading: loading ?? this.loading,
      signupMethod: signupMethod ?? this.signupMethod,
      error: clearError ? null : error ?? this.error,
    );
  }
}
