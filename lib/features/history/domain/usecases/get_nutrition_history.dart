import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/history/data/model/nutrition_history.dart';
import 'package:kaloree/features/history/domain/repositories/analysis_repository.dart';

class GetNutritionHistoryUseCase
    implements UseCase<NutritionHistory, NoParams> {
  final AnalysisRepository repository;

  GetNutritionHistoryUseCase(this.repository);
  @override
  Future<Either<Failure, NutritionHistory>> call(NoParams params) async {
    return await repository.getNutritionHistoryInMonth();
  }
}
