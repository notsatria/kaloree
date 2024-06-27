part of 'get_user_data_bloc.dart';

sealed class GetUserDataState extends Equatable {
  const GetUserDataState();

  @override
  List<Object> get props => [];
}

final class GetUserDataInitial extends GetUserDataState {}

final class GetUserDataSuccess extends GetUserDataState {
  final UserModel user;

  const GetUserDataSuccess(this.user);
}

final class GetUserDataFailure extends GetUserDataState {
  final String message;

  const GetUserDataFailure(this.message);
}
