import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/health_profile.dart';
import 'package:kaloree/core/model/user_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<UserModel> getUserData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  HomeRemoteDataSourceImpl(this.firebaseAuth, this.firebaseFirestore);
  @override
  Future<UserModel> getUserData() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw ServerException("User not authenticated");
      }
      DocumentSnapshot userDocSnapshot =
          await firebaseFirestore.collection("users").doc(user.uid).get();

      DocumentReference healthProfileDoc = firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection("health_profile")
          .doc(user.uid);

      DocumentSnapshot healthProfileSnapshot = await healthProfileDoc.get();

      Map<String, dynamic> data =
          healthProfileSnapshot.data() as Map<String, dynamic>;
      final healthProfile = HealthProfile.fromMap(data);

      if (userDocSnapshot.exists) {
        Map<String, dynamic> data =
            userDocSnapshot.data() as Map<String, dynamic>;
        return UserModel(
          email: data['email'],
          uid: data['uid'],
          updatedAt: data['updatedAt'],
          fullName: data['fullName'],
          healthProfile: healthProfile,
          isAssesmentComplete: data['isAssesmentComplete'],
          profilePicture: data['profilePicture'],
        );
      } else {
        debugPrint("Error on getUser: User not found");
        throw ServerException("User not found");
      }
    } catch (e) {
      debugPrint("Error on getUser: $e");
      throw ServerException(e.toString());
    }
  }
}
