import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  

  @override
  Future<Either<Failure, Unit>> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
