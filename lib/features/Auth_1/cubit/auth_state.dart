abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String role;
  final bool needEmailVerification;

  AuthSuccess(this.role, {this.needEmailVerification = false});
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
