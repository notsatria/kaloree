import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/assesment/domain/usecases/get_user_data.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final GetUserDataUseCase _getUserDataUseCase;
  UserHomeBloc({
    required GetUserDataUseCase getUserDataUseCase,
  })  : _getUserDataUseCase = getUserDataUseCase,
        super(UserHomeInitial()) {
    on<GetUserData>(_onGetUserData);
  }

  void _onGetUserData(GetUserData event, Emitter<UserHomeState> emit) async {
    final result = await _getUserDataUseCase(NoParams());

    result.fold(
      (failure) => emit(GetUserDataFailure(failure.message)),
      (res) => emit(GetUserDataSuccess(res)),
    );
  }
}
