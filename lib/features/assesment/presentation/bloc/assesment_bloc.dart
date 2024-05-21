import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_save_assesment.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_update_gender.dart';

part 'assesment_event.dart';
part 'assesment_state.dart';

class AssesmentBloc extends Bloc<AssesmentEvent, AssesmentState> {
  final UserSaveAssesment _userSaveAssesment;
  final UserUpdateGender _userUpdateGender;
  AssesmentBloc(
      {required UserSaveAssesment userSaveAssesment,
      required UserUpdateGender userUpdateGender})
      : _userSaveAssesment = userSaveAssesment,
        _userUpdateGender = userUpdateGender,
        super(AssesmentInitial()) {
    on<AssesmentEvent>((_, emit) => emit(AssesmentLoading()));

    on<SavePersonalInfo>(_onUploadPersonalInfo);

    on<UpdateGender>(_onUpdateGender);
  }

  void _onUploadPersonalInfo(
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

  void _onUpdateGender(UpdateGender event, Emitter<AssesmentState> emit) async {
    final result =
        await _userUpdateGender(UserUpdateGenderParams(gender: event.gender));

    result.fold(
      (failure) => emit(AssesmentFailure(failure.message)),
      (_) => emit(AssesmentSuccess()),
    );
  }
}
