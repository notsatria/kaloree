import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/user_model.dart' as user_model;

abstract interface class AuthRemoteDataSource {
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<user_model.UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<user_model.UserModel> signInWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firebaseFirestore,
    this.googleSignIn,
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

        final user = user_model.UserModel(
          uid: firebaseUser.uid,
          email: email,
          fullName: "",
          isAssesmentComplete: false,
          profilePicture:
              "https://firebasestorage.googleapis.com/v0/b/kaloree-app.appspot.com/o/default%2Fimg_avatar.png?alt=media&token=53db1be0-9e7d-4aea-83c1-4e1aecd882be",
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
  Future<user_model.UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final auth = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentReference userCollection =
          firebaseFirestore.collection('users').doc(auth.user?.uid);
      DocumentSnapshot userSnapshot = await userCollection.get();

      if (userSnapshot.exists) {
        Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
        debugPrint("User: ${user_model.UserModel.fromMap(data)}");
        return user_model.UserModel.fromMap(data);
      } else {
        throw ServerException("User Snaphot doesnt exists");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
 @override
  Future<user_model.UserModel> signInWithGoogle() async {
    try {
      final googleSignInAccount = await googleSignIn.signIn();
      final googleSignInAuthentication = await googleSignInAccount?.authentication;

      if (googleSignInAuthentication == null) {
        throw ServerException("Google sign-in authentication failed.");
      }

      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await firebaseAuth.signInWithCredential(authCredential);
      final firebaseUser = authResult.user;

      if (firebaseUser == null) {
        throw ServerException("Failed to sign in with Google.");
      }

      final userDoc = await firebaseFirestore.collection('users').doc(firebaseUser.uid).get();
      if (userDoc.exists) {
        return user_model.UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      } else {
        final newUser = user_model.UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          fullName: firebaseUser.displayName ?? '',
          isAssesmentComplete: false,
          profilePicture: firebaseUser.photoURL ?? '',
          updatedAt: DateTime.now().toString(),
        );

        await firebaseFirestore.collection('users').doc(firebaseUser.uid).set(newUser.toMap());
        return newUser;
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
