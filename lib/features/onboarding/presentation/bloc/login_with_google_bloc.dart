import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/auth/domain/usecases/user_login_google.dart';

part 'login_with_google_event.dart';
part 'login_with_google_state.dart';

class LoginWithGoogleBloc
    extends Bloc<LoginWithGoogleEvent, LoginWithGoogleState> {
  final UserLoginGoogleUseCase _userLoginGoogleUseCase;

  LoginWithGoogleBloc({required UserLoginGoogleUseCase userLoginGoogleUseCase})
      : _userLoginGoogleUseCase = userLoginGoogleUseCase,
        super(LoginWithGoogleInitial()) {
    on<LoginWithGoogleEvent>((event, emit) async {
      emit(LoginWithGoogleLoading());
      final result = await _userLoginGoogleUseCase(NoParams());
      result.fold(
        (l) => emit(LoginWithGoogleFailure(l.message)),
        (r) => emit(LoginWithGoogleSuccess(r)),
      );
    });
  }
}
