import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/user_model.dart' as user_model;

abstract interface class AuthRemoteDataSource {
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firebaseFirestore,
  );

  @override
  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      CollectionReference users = firebaseFirestore.collection("users");

      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        final firebaseUser = value.user;

        if (firebaseUser == null) {
          throw ServerException('Failed to create user.');
        }

        final user = user_model.User(
          uid: firebaseUser.uid,
          email: email,
          fullName: "",
          isAssesmentComplete: false,
          profilePicture:
              "https://firebasestorage.googleapis.com/v0/b/kaloree-b1523.appspot.com/o/user%2Fprofile_picture%2Fdefault_profile.png?alt=media&token=23b190e3-b3e8-4dec-84fd-5ee72425405d",
          classificationResultList: [],
          updatedAt: DateTime.now().toString(),
        );

        users.doc(firebaseUser.uid).set(user.toMap());
      });
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

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
