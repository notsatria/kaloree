part of 'get_total_calories_in_week_bloc.dart';

sealed class GetTotalCaloriesInWeekState extends Equatable {
  const GetTotalCaloriesInWeekState();

  @override
  List<Object> get props => [];
}

final class GetTotalCaloriesInWeekInitial extends GetTotalCaloriesInWeekState {}

final class GetTotalCaloriesInWeekSuccess extends GetTotalCaloriesInWeekState {
  final Map<String, double> weeklyCalories;

  const GetTotalCaloriesInWeekSuccess(this.weeklyCalories);
}

final class GetTotalCaloriesInWeekFailure extends GetTotalCaloriesInWeekState {
  final String message;

  const GetTotalCaloriesInWeekFailure(this.message);
}
