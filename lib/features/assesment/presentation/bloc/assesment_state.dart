part of 'assesment_bloc.dart';

sealed class AssesmentState extends Equatable {
  const AssesmentState();

  @override
  List<Object> get props => [];
}

final class AssesmentInitial extends AssesmentState {}

final class AssesmentLoading extends AssesmentState {}

final class AssesmentSuccess extends AssesmentState {}

final class AssesmentFailure extends AssesmentState {
  final String message;

  const AssesmentFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class PersonalInfoSaved extends AssesmentState {
  final String fullName;
  final String dateOfBirth;
  final int gender;
  final int weight;
  final int height;
  final String userId;
  final int activityStatus;
  final int healthPurpose;

  const PersonalInfoSaved({
    this.fullName = "",
    this.dateOfBirth = "",
    this.gender = 0,
    this.weight = 0,
    this.height = 0,
    this.userId = "",
    this.activityStatus = 0,
    this.healthPurpose = 0,
  });
}
