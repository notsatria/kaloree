import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaloree/features/home/data/model/recommendation.dart';
import 'package:kaloree/features/profile/domain/usecases/get_recommendation.dart';

part 'get_recommendation_event.dart';
part 'get_recommendation_state.dart';

class GetRecommendationBloc
    extends Bloc<GetRecommendationEvent, GetRecommendationState> {
  final GetRecommendationUseCase _getRecommendationUseCase;
  GetRecommendationBloc(
      {required GetRecommendationUseCase getRecommendationUseCase})
      : _getRecommendationUseCase = getRecommendationUseCase,
        super(GetRecommendationInitial()) {
    on<GetRecommendationList>(_getRecommendationList);
  }

  void _getRecommendationList(
      GetRecommendationList event, Emitter<GetRecommendationState> emit) async {
    emit(GetRecommendationLoading());
    final result = await _getRecommendationUseCase(
        GetRecommendationParams(event.isSportRecommendation));
    result.fold(
      (l) => emit(GetRecommendationFailure(l.toString())),
      (r) => emit(GetRecommendationSuccess(r)),
    );
  }
}
