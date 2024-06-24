import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';

abstract interface class AnalysisRepository {
  Future<Either<Failure, Map<String, double>>> getTotalCaloriesInWeek();
}
