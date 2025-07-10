part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthDone extends AuthState {
  const AuthDone();
}

final class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}

//logout

final class AuthLogingout extends AuthState {
  const AuthLogingout();
}

final class AuthLogedout extends AuthState {
  const AuthLogedout();
}

final class AuthLogoutError extends AuthState {
  final String message;
  AuthLogoutError({required this.message});
}

final class GoogleAuthunticated extends AuthState {
  const GoogleAuthunticated();
}

final class GoogleAuthDone extends AuthState {
  const GoogleAuthDone();
}

final class GoogleAuthError extends AuthState {
  final String message;
  GoogleAuthError({required this.message});
}
