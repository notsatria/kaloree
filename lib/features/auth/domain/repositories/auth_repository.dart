
import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, void>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}