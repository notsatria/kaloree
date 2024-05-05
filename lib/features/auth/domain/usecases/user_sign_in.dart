import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/auth/domain/repositories/auth_repository.dart';

class UserSignIn implements UseCase<void, UserSignInParams> {
  final AuthRepository repository;

  UserSignIn(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}
