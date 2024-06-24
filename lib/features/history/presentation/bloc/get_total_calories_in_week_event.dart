part of 'get_total_calories_in_week_bloc.dart';

sealed class GetTotalCaloriesInWeekEvent extends Equatable {
  const GetTotalCaloriesInWeekEvent();

  @override
  List<Object> get props => [];
}

final class GetTotalCaloriesInWeek extends GetTotalCaloriesInWeekEvent {}