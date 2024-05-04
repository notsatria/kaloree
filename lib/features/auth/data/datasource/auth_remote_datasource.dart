import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaloree/core/errors/exceptions.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);
  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else if (e.code == 'weak-password') {
        throw WeakPasswordException();
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
