abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final String role;

  const AuthSuccess({required this.role});
}

class AuthNeedEmailVerification extends AuthState {
  final String message;

  const AuthNeedEmailVerification({required this.message});
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
