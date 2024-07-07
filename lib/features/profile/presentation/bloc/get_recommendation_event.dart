part of 'get_recommendation_bloc.dart';

sealed class GetRecommendationEvent extends Equatable {
  const GetRecommendationEvent();

  @override
  List<Object> get props => [];
}

final class GetRecommendationList extends GetRecommendationEvent {
  final bool isSportRecommendation;

  const GetRecommendationList({required this.isSportRecommendation});
}
