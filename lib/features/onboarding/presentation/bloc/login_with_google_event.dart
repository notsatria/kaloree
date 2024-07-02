part of 'login_with_google_bloc.dart';

sealed class LoginWithGoogleEvent extends Equatable {
  const LoginWithGoogleEvent();

  @override
  List<Object> get props => [];
}

final class LoginWithGoogle extends LoginWithGoogleEvent {}