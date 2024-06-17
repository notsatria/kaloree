import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/catatan/data/model/catatan_list_by_month.dart';
import 'package:kaloree/features/catatan/domain/usecases/get_catatan_list_by_month_usecase.dart';

part 'catatan_event.dart';
part 'catatan_state.dart';

class CatatanBloc extends Bloc<CatatanEvent, CatatanState> {
  final GetCatatanListByMonthUseCase _getCatatanListByMonthUseCase;
  CatatanBloc({
    required GetCatatanListByMonthUseCase getCatatanListByMonthUseCase,
  })  : _getCatatanListByMonthUseCase = getCatatanListByMonthUseCase,
        super(CatatanInitial()) {
    on<GetCatatanListByMonth>(_getCatatanListByMonth);
  }

  void _getCatatanListByMonth(
      GetCatatanListByMonth event, Emitter<CatatanState> emit) async {
    emit(CatatanLoading());
    final result = await _getCatatanListByMonthUseCase(NoParams());

    result.fold(
      (failure) => emit(CatatanFailure(failure.message)),
      (res) => emit(CatatanSuccess(res)),
    );
  }
}
