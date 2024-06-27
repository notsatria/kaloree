import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/profile/domain/usecases/get_user_data_on_profile.dart';

part 'get_user_data_on_profile_event.dart';
part 'get_user_data_on_profile_state.dart';

class GetUserDataOnProfileBloc
    extends Bloc<GetUserDataOnProfileEvent, GetUserDataOnProfileState> {
  final GetUserDataOnProfileUseCase _getUserDataOnProfileUseCase;
  GetUserDataOnProfileBloc(
      {required GetUserDataOnProfileUseCase getUserDataOnProfileUseCase})
      : _getUserDataOnProfileUseCase = getUserDataOnProfileUseCase,
        super(GetUserDataOnProfileInitial()) {
    on<GetUserDataOnProfileEvent>(_onGetUserDataOnProfile);
  }

  void _onGetUserDataOnProfile(GetUserDataOnProfileEvent event,
      Emitter<GetUserDataOnProfileState> emit) async {
    emit(GetUserDataOnProfileLoading());
    final result = await _getUserDataOnProfileUseCase(NoParams());

    result.fold(
      (l) => emit(GetUserDataOnProfileFailure(l.message)),
      (r) => emit(GetUserDataOnProfileSuccess(r)),
    );
  }
}
