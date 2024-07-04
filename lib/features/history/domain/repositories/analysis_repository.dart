import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/features/history/data/model/nutrition_history.dart';

abstract interface class AnalysisRepository {
  Future<Either<Failure, Map<String, double>>> getTotalCaloriesInWeek();
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, NutritionHistory>> getNutritionHistoryInMonth();
}
