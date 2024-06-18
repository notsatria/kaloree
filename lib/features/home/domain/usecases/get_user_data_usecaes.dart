import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/home/domain/repositories/home_repository.dart';

class GetUserDataUseCase implements UseCase<UserModel, NoParams> {
  final HomeRepository repository;

  GetUserDataUseCase(this.repository);
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
