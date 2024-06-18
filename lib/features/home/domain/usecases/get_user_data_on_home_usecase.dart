import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/home/domain/repositories/home_repository.dart';

class GetUserDataOnHomeUseCase implements UseCase<UserModel, NoParams> {
  final HomeRepository repository;

  GetUserDataOnHomeUseCase(this.repository);
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
