part of 'get_user_data_on_profile_bloc.dart';

sealed class GetUserDataOnProfileEvent extends Equatable {
  const GetUserDataOnProfileEvent();

  @override
  List<Object> get props => [];
}

final class ClassGetUserDataOnProfile extends GetUserDataOnProfileEvent {}
