part of 'save_recommendation_bloc.dart';

sealed class SaveRecommendationEvent extends Equatable {
  const SaveRecommendationEvent();

  @override
  List<Object> get props => [];
}

final class SaveRecommendation extends SaveRecommendationEvent {
  final bool isSportRecommendation;
  final String result;

  const SaveRecommendation(
      {required this.isSportRecommendation, required this.result});
}
