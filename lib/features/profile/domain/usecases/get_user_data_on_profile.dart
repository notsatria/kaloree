import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/profile/domain/repositories/profile_repository.dart';

class GetUserDataOnProfileUseCase implements UseCase<UserModel, NoParams> {
  final ProfileRepository repository;

  GetUserDataOnProfileUseCase(this.repository);
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
