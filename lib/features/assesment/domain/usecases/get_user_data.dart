import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';

class GetUserDataUseCase implements UseCase<UserModel, NoParams> {
  final AssesmentRepository repository;

  GetUserDataUseCase(this.repository);
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getUser();
  }
}
