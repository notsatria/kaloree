part of 'get_user_data_on_profile_bloc.dart';

sealed class GetUserDataOnProfileState extends Equatable {
  const GetUserDataOnProfileState();

  @override
  List<Object> get props => [];
}

final class GetUserDataOnProfileInitial extends GetUserDataOnProfileState {}

final class GetUserDataOnProfileLoading extends GetUserDataOnProfileState {}

final class GetUserDataOnProfileSuccess extends GetUserDataOnProfileState {
  final UserModel user;

  const GetUserDataOnProfileSuccess(this.user);
}

final class GetUserDataOnProfileFailure extends GetUserDataOnProfileState {
  final String message;

  const GetUserDataOnProfileFailure(this.message);
}
