part of 'daily_calories_bloc.dart';

sealed class DailyCaloriesState extends Equatable {
  const DailyCaloriesState();
  
  @override
  List<Object> get props => [];
}

final class DailyCaloriesInitial extends DailyCaloriesState {}


final class GetDailyCaloriesSuppliedFailure extends DailyCaloriesState {
  final String message;

  const GetDailyCaloriesSuppliedFailure(this.message);
}

final class GetDailyCaloriesSuppliedSuccess extends DailyCaloriesState {
  final double dailyCaloriesSupplied;

  const GetDailyCaloriesSuppliedSuccess(this.dailyCaloriesSupplied);
}
