import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/history/domain/usecases/get_total_calories_in_week.dart';

part 'get_total_calories_in_week_event.dart';
part 'get_total_calories_in_week_state.dart';

class GetTotalCaloriesInWeekBloc
    extends Bloc<GetTotalCaloriesInWeekEvent, GetTotalCaloriesInWeekState> {
  final GetTotalCaloriesInWeekUseCase _getTotalCaloriesInWeekUseCase;
  GetTotalCaloriesInWeekBloc(
      {required GetTotalCaloriesInWeekUseCase getTotalCaloriesInWeekUseCase})
      : _getTotalCaloriesInWeekUseCase = getTotalCaloriesInWeekUseCase,
        super(GetTotalCaloriesInWeekInitial()) {
    on<GetTotalCaloriesInWeek>(_onGetTotalCaloriesInWeek);
  }

  void _onGetTotalCaloriesInWeek(GetTotalCaloriesInWeek event,
      Emitter<GetTotalCaloriesInWeekState> emit) async {
    final result = await _getTotalCaloriesInWeekUseCase(NoParams());

    result.fold(
      (failure) => emit(GetTotalCaloriesInWeekFailure(failure.message)),
      (r) => emit(GetTotalCaloriesInWeekSuccess(r)),
    );
  }
}
