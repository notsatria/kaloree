import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/home/domain/repositories/home_repository.dart';

class GetDailyCaloriesSuppliedUseCase implements UseCase<double, NoParams> {
  final HomeRepository repository;

  GetDailyCaloriesSuppliedUseCase(this.repository);
  @override
  Future<Either<Failure, double>> call(NoParams params) async {
    return await repository.getDailyCaloriesSupplied();
  }
}
