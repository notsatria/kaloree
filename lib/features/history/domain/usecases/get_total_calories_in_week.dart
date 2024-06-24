import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/history/domain/repositories/history_repository.dart';

class GetTotalCaloriesInWeekUseCase
    implements UseCase<Map<String, double>, NoParams> {
  final HistoryRepository repository;

  GetTotalCaloriesInWeekUseCase(this.repository);
  @override
  Future<Either<Failure, Map<String, double>>> call(NoParams params) async {
    return await repository.getTotalCaloriesInWeek();
  }
}
