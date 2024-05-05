import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:kaloree/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(null);
    } on EmailAlreadyInUseException catch (e) {
      return left(Failure(e.message));
    } on WeakPasswordException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(null);
    } on UserNotFoundException catch (e) {
      return left(Failure(e.message));
    } on WrongPasswordException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
