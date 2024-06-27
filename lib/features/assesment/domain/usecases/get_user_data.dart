import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';

class GetUserDataOnAssesmentUseCase implements UseCase<UserModel, NoParams> {
  final AssesmentRepository repository;

  GetUserDataOnAssesmentUseCase(this.repository);
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getUser();
  }
}
