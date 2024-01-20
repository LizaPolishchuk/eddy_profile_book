abstract class AuthState {
  const AuthState();
}

class SignInInitial extends AuthState {}

class AuthLoading extends AuthState {}

class SignInSuccess extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignOutSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);
}
