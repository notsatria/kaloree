part of 'get_nutrition_in_month_bloc.dart';

sealed class GetNutritionInMonthEvent extends Equatable {
  const GetNutritionInMonthEvent();

  @override
  List<Object> get props => [];
}

final class GetNutritionInMonth extends GetNutritionInMonthEvent {}