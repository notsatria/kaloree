import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/auth/domain/repositories/auth_repository.dart';

class UserLoginGoogleUseCase implements UseCase<UserModel, NoParams> {
  final AuthRepository repository;

  UserLoginGoogleUseCase(this.repository);
  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.signInWithGoogle();
  }
}
