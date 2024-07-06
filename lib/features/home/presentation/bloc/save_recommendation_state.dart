part of 'save_recommendation_bloc.dart';

sealed class SaveRecommendationState extends Equatable {
  const SaveRecommendationState();

  @override
  List<Object> get props => [];
}

final class SaveRecommendationInitial extends SaveRecommendationState {}

final class SaveRecommendationLoading extends SaveRecommendationState {}

final class SaveRecommendationSuccess extends SaveRecommendationState {
  final String message;

  const SaveRecommendationSuccess(this.message);
}

final class SaveRecommendationFailure extends SaveRecommendationState {
  final String message;

  const SaveRecommendationFailure(this.message);
}
