import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/home/domain/usecases/get_user_data_on_home_usecase.dart';

part 'user_home_event.dart';
part 'user_home_state.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  final GetUserDataOnHomeUseCase _getUserDataUseCase;
  UserHomeBloc({
    required GetUserDataOnHomeUseCase getUserDataUseCase,
  })  : _getUserDataUseCase = getUserDataUseCase,
        super(UserHomeInitial()) {
    on<GetUserData>(_onGetUserData);
  }

  void _onGetUserData(GetUserData event, Emitter<UserHomeState> emit) async {
    emit(GetUserDataLoading());
    final result = await _getUserDataUseCase(NoParams());

    result.fold(
      (failure) => emit(GetUserDataFailure(failure.message)),
      (res) => emit(GetUserDataSuccess(res)),
    );
  }
}
