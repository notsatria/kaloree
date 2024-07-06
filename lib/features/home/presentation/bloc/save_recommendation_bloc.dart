import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/home/domain/usecases/save_recommendation.dart';

part 'save_recommendation_event.dart';
part 'save_recommendation_state.dart';

class SaveRecommendationBloc
    extends Bloc<SaveRecommendationEvent, SaveRecommendationState> {
  final SaveRecommendationUseCase _saveRecommendationUseCase;
  SaveRecommendationBloc(
      {required SaveRecommendationUseCase saveRecommendationUseCase})
      : _saveRecommendationUseCase = saveRecommendationUseCase,
        super(SaveRecommendationInitial()) {
    on<SaveRecommendation>(_onSaveRecommendation);
  }

  void _onSaveRecommendation(
      SaveRecommendation event, Emitter<SaveRecommendationState> emit) async {
    emit(SaveRecommendationLoading());
    final result = await _saveRecommendationUseCase(
      SaveRecommendationParams(
          isSportRecommendation: event.isSportRecommendation,
          result: event.result),
    );

    result.fold(
      (l) => emit(SaveRecommendationFailure(l.message)),
      (_) => emit(
          const SaveRecommendationSuccess('Rekomendasi berhasil disimpan')),
    );
  }
}
