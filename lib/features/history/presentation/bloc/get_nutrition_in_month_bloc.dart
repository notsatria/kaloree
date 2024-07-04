import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/history/data/model/nutrition_history.dart';
import 'package:kaloree/features/history/domain/usecases/get_nutrition_history.dart';

part 'get_nutrition_in_month_event.dart';
part 'get_nutrition_in_month_state.dart';

class GetNutritionInMonthBloc
    extends Bloc<GetNutritionInMonthEvent, GetNutritionInMonthState> {
  final GetNutritionHistoryUseCase _getNutritionHistoryUseCase;
  GetNutritionInMonthBloc(
      {required GetNutritionHistoryUseCase getNutritionHistoryUseCase})
      : _getNutritionHistoryUseCase = getNutritionHistoryUseCase,
        super(GetNutritionInMonthInitial()) {
    on<GetNutritionInMonth>(_onGetNutritionInMonth);
  }

  _onGetNutritionInMonth(
      GetNutritionInMonth event, Emitter<GetNutritionInMonthState> emit) async {
    emit(GetNutritionInMonthLoading());
    final result = await _getNutritionHistoryUseCase(NoParams());

    result.fold(
      (l) => emit(GetNutritionInMonthFailure(l.message)),
      (r) => emit(GetNutritionInMonthSuccess(r)),
    );
  }
}
