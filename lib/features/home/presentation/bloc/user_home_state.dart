part of 'user_home_bloc.dart';

sealed class UserHomeState extends Equatable {
  const UserHomeState();

  @override
  List<Object> get props => [];
}

final class UserHomeInitial extends UserHomeState {}

final class GetUserDataLoading extends UserHomeState {}

final class GetUserDataFailure extends UserHomeState {
  final String message;

  const GetUserDataFailure(this.message);
}

final class GetUserDataSuccess extends UserHomeState {
  final UserModel user;

  const GetUserDataSuccess(this.user);
}
