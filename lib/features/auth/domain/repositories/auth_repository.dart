
import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Unit>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
}