import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/auth/domain/repositories/auth_repository.dart';

class UserSignUp implements UseCase<void, UserSignUpParams> {
  final AuthRepository repository;

  UserSignUp(this.repository);

  @override
  Future<Either<Failure, void>> call(UserSignUpParams params) async {
    return await repository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  UserSignUpParams({
    required this.email,
    required this.password,
  });
}
