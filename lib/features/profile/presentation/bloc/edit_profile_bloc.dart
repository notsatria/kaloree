import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/profile/domain/usecases/edit_profile.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  EditProfileBloc({required EditProfileUseCase editProfileUseCase})
      : _editProfileUseCase = editProfileUseCase,
        super(EditProfileInitial()) {
    on<EditProfile>(_onEditProfile);
  }

  _onEditProfile(EditProfile event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoading());
    final result =
        await _editProfileUseCase(EditProfileUseCaseParams(event.fullName, event.image));

    result.fold(
      (l) => emit(EditProfileFailure(l.toString())),
      (_) => emit(EditProfileSuccess()),
    );
  }
}
