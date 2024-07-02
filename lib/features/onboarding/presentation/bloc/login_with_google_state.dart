part of 'login_with_google_bloc.dart';

sealed class LoginWithGoogleState extends Equatable {
  const LoginWithGoogleState();

  @override
  List<Object> get props => [];
}

final class LoginWithGoogleInitial extends LoginWithGoogleState {}

final class LoginWithGoogleLoading extends LoginWithGoogleState {}

final class LoginWithGoogleSuccess extends LoginWithGoogleState {
  final UserModel user;

  const LoginWithGoogleSuccess(this.user);
}

final class LoginWithGoogleFailure extends LoginWithGoogleState {
  final String message;

  const LoginWithGoogleFailure(this.message);
}
