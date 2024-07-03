import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/auth/domain/usecases/user_login_google.dart';
import 'package:kaloree/features/auth/domain/usecases/user_sign_in.dart';
import 'package:kaloree/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final UserLoginGoogleUseCase _userLoginGoogleUseCase;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required UserLoginGoogleUseCase userLoginGoogleUseCase,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _userLoginGoogleUseCase = userLoginGoogleUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthInitial()));

    on<AuthSignUp>(_onAuthSignUp);

    on<AuthSignIn>(_onAuthSignIn);

    on<AuthLoginWithGoogle>(_onAuthLoginWithGoogle);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoadingOnLoadingWithEmailAndPassword());

    final result = await _userSignUp(UserSignUpParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthRegisterSuccess()),
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoadingOnLoadingWithGoogle());

    final result = await _userSignIn(UserSignInParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (res) => emit(AuthLoginSuccess(res)),
    );
  }

  void _onAuthLoginWithGoogle(
      AuthLoginWithGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoadingOnLoadingWithGoogle());
    final result = await _userLoginGoogleUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (r) => emit(AuthLoginSuccess(r)),
    );
  }
}
