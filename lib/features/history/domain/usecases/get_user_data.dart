import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/history/domain/repositories/analysis_repository.dart';

class GetUserDataOnAnalysisUseCase implements UseCase<UserModel, NoParams> {
  final AnalysisRepository repository;

  GetUserDataOnAnalysisUseCase(this.repository);
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
