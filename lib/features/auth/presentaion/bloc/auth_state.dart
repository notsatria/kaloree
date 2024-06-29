part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoadingOnLoadingWithEmailAndPassword extends AuthState {}

final class AuthLoadingOnLoadingWithGoogle extends AuthState {}

final class AuthRegisterSuccess extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final UserModel user;

  const AuthLoginSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}
