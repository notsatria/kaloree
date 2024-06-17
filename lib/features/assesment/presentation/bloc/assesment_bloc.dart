import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/assesment/domain/usecases/get_user_data.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_save_assesment.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_update_gender.dart';
import 'package:kaloree/features/assesment/domain/usecases/user_update_last_assesment_data.dart';

part 'assesment_event.dart';
part 'assesment_state.dart';

class AssesmentBloc extends Bloc<AssesmentEvent, AssesmentState> {
  final UserSaveAssesment _userSaveAssesment;
  final UserUpdateGender _userUpdateGender;
  final UserUpdateLastAssesment _userUpdateLastAssesment;
  final GetUserDataUseCase _getUserDataUseCase;

  AssesmentBloc({
    required UserSaveAssesment userSaveAssesment,
    required UserUpdateGender userUpdateGender,
    required UserUpdateLastAssesment userUpdateLastAssesment,
    required GetUserDataUseCase getUserDataUseCase,
  })  : _userSaveAssesment = userSaveAssesment,
        _userUpdateGender = userUpdateGender,
        _userUpdateLastAssesment = userUpdateLastAssesment,
        _getUserDataUseCase = getUserDataUseCase,
        super(AssesmentInitial()) {
    on<AssesmentEvent>((_, emit) => emit(AssesmentLoading()));

    on<SavePersonalInfo>(_onUploadPersonalInfo);

    on<UpdateGender>(_onUpdateGender);

    on<UpdateLastAssesment>(_onUpdateLastAssesment);

    on<GetUserData>(_onGetUserData);
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

  void _onUpdateLastAssesment(
      UpdateLastAssesment event, Emitter<AssesmentState> emit) async {
    final result = await _userUpdateLastAssesment(
      UserUpdateLastAssesmentParams(
          weight: event.weight,
          height: event.height,
          activityStatus: event.activityStatus,
          healthPurpose: event.healthPurpose),
    );

    result.fold(
      (failure) => emit(AssesmentFailure(failure.message)),
      (_) => emit(AssesmentComplete()),
    );
  }

  void _onGetUserData(GetUserData event, Emitter<AssesmentState> emit) async {
    final result = await _getUserDataUseCase(NoParams());

    debugPrint('Result _onGetUserData: $result');

    result.fold(
      (failure) => emit(GetUserDataFailed(failure.message)),
      (r) => emit(GetUserDataSuccess(r)),
    );
  }
}
