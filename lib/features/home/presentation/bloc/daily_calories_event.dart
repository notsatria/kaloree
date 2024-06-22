part of 'daily_calories_bloc.dart';

sealed class DailyCaloriesEvent extends Equatable {
  const DailyCaloriesEvent();

  @override
  List<Object> get props => [];
}

class GetDailyCaloriesSupplied extends DailyCaloriesEvent {}
