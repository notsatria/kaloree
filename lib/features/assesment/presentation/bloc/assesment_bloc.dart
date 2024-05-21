import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_save_assesment.dart';

part 'assesment_event.dart';
part 'assesment_state.dart';

class AssesmentBloc extends Bloc<AssesmentEvent, AssesmentState> {
  final UserSaveAssesment _userSaveAssesment;
  AssesmentBloc({required UserSaveAssesment userSaveAssesment})
      : _userSaveAssesment = userSaveAssesment,
        super(AssesmentInitial()) {
    on<SavePersonalInfo>(_onSavePersonalInfo);

    on<UploadPersonalInfo>(_onUploadPersonalInfo);
  }

  void _onSavePersonalInfo(
      SavePersonalInfo event, Emitter<AssesmentState> emit) async {
    final result = await _userSaveAssesment(
      UserSaveAssesmentParams(
        fullName: event.fullName,
        dateOfBirth: event.dateOfBirth,
        gender: event.gender,
        weight: event.weight,
        height: event.height,
        activityStatus: event.activityStatus,
        healthPurpose: event.healthPurpose,
      ),
    );

    result.fold(
      (failure) => emit(AssesmentFailure(failure.message)),
      (_) => emit(AssesmentSuccess()),
    );
  }

  void _onUploadPersonalInfo(
      UploadPersonalInfo event, Emitter<AssesmentState> emit) async {
    final result = await _userSaveAssesment(
      UserSaveAssesmentParams(
        fullName: event.personalInfoSaved.fullName,
        dateOfBirth: event.personalInfoSaved.dateOfBirth,
        gender: event.personalInfoSaved.gender,
        weight: event.personalInfoSaved.weight,
        height: event.personalInfoSaved.height,
        activityStatus: event.personalInfoSaved.activityStatus,
        healthPurpose: event.personalInfoSaved.healthPurpose,
      ),
    );

    result.fold(
      (failure) => emit(AssesmentFailure(failure.message)),
      (_) => emit(AssesmentSuccess()),
    );
  }
}
