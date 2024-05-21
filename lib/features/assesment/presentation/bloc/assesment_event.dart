part of 'assesment_bloc.dart';

sealed class AssesmentEvent extends Equatable {
  const AssesmentEvent();

  @override
  List<Object> get props => [];
}

class SavePersonalInfo extends AssesmentEvent {
  final String fullName;
  final String dateOfBirth;
  final int gender;
  final int weight;
  final int height;
  final String userId;
  final int activityStatus;
  final int healthPurpose;

  const SavePersonalInfo({
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

class UploadPersonalInfo extends AssesmentEvent {
  final PersonalInfoSaved personalInfoSaved;

 const  UploadPersonalInfo({required this.personalInfoSaved});
}
