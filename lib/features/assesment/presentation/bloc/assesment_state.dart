part of 'assesment_bloc.dart';

sealed class AssesmentState extends Equatable {
  const AssesmentState();

  @override
  List<Object> get props => [];
}

final class AssesmentInitial extends AssesmentState {}

final class AssesmentLoading extends AssesmentState {}

final class AssesmentSuccess extends AssesmentState {}

final class AssesmentComplete extends AssesmentState {}

final class GetUserDataFailed extends AssesmentState {
  final String message;

  const GetUserDataFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class GetUserDataSuccess extends AssesmentState {
  final UserModel userModel;

  const GetUserDataSuccess(this.userModel);
}

final class GetUserHealthProfileSuccess extends AssesmentState {
  final HealthProfile healthProfile;

  const GetUserHealthProfileSuccess(this.healthProfile);
}

final class AssesmentFailure extends AssesmentState {
  final String message;

  const AssesmentFailure(this.message);

  @override
  List<Object> get props => [message];
}
