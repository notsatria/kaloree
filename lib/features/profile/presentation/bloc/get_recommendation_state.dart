part of 'get_recommendation_bloc.dart';

sealed class GetRecommendationState extends Equatable {
  const GetRecommendationState();

  @override
  List<Object> get props => [];
}

final class GetRecommendationInitial extends GetRecommendationState {}

final class GetRecommendationLoading extends GetRecommendationState {}

final class GetRecommendationSuccess extends GetRecommendationState {
  final List<Recommendation> recommendationList;

  const GetRecommendationSuccess(this.recommendationList);
}

final class GetRecommendationFailure extends GetRecommendationState {
  final String message;

  const GetRecommendationFailure(this.message);
}
