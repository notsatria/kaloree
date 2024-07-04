part of 'get_nutrition_in_month_bloc.dart';

sealed class GetNutritionInMonthState extends Equatable {
  const GetNutritionInMonthState();

  @override
  List<Object> get props => [];
}

final class GetNutritionInMonthInitial extends GetNutritionInMonthState {}

final class GetNutritionInMonthLoading extends GetNutritionInMonthState {}

final class GetNutritionInMonthSuccess extends GetNutritionInMonthState {
  final NutritionHistory nutritionHistory;

  const GetNutritionInMonthSuccess(this.nutritionHistory);
}

final class GetNutritionInMonthFailure extends GetNutritionInMonthState {
  final String message;

  const GetNutritionInMonthFailure(this.message);
}
