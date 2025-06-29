part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String email;
  AuthSuccess(this.email);
}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
