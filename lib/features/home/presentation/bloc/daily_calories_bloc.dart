import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/home/domain/usecases/get_daily_calories_supplied_usecase.dart';

part 'daily_calories_event.dart';
part 'daily_calories_state.dart';

class DailyCaloriesBloc extends Bloc<DailyCaloriesEvent, DailyCaloriesState> {
  final GetDailyCaloriesSuppliedUseCase _getDailyCaloriesSuppliedUseCase;

  DailyCaloriesBloc(
      {required GetDailyCaloriesSuppliedUseCase
          getDailyCaloriesSuppliedUseCase})
      : _getDailyCaloriesSuppliedUseCase = getDailyCaloriesSuppliedUseCase,
        super(DailyCaloriesInitial()) {
    on<GetDailyCaloriesSupplied>(_onGetDailyCaloriesSupplied);
  }

  void _onGetDailyCaloriesSupplied(
      GetDailyCaloriesSupplied event, Emitter<DailyCaloriesState> emit) async {
    final result = await _getDailyCaloriesSuppliedUseCase(NoParams());
    result.fold(
      (failure) => emit(GetDailyCaloriesSuppliedFailure(failure.message)),
      (r) => emit(GetDailyCaloriesSuppliedSuccess(r)),
    );
  }
}
