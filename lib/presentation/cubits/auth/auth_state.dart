part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final ResponseLoginEntity response;
  AuthSuccess({required this.response});
}

class AuthRegisterSuccess extends AuthState {
  final String response;
  AuthRegisterSuccess({required this.response});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
