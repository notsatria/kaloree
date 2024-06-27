part of 'get_user_data_bloc.dart';

sealed class GetUserDataEvent extends Equatable {
  const GetUserDataEvent();

  @override
  List<Object> get props => [];
}

final class GetUserData extends GetUserDataEvent {}