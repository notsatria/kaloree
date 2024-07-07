import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/health_profile.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/features/home/data/model/recommendation.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> getUserData();
  Future<void> editProfile({required String fullName, File? image});
  Future<List<Recommendation>> getRecommendation(
      {required bool isSportRecommendation});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ProfileRemoteDataSourceImpl(
      this.firebaseAuth, this.firebaseFirestore, this.firebaseStorage);
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
        log("Error on getUser: User not found");
        throw ServerException("User not found");
      }
    } catch (e) {
      log("Error on getUser: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> editProfile({required String fullName, File? image}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw ServerException("User not authenticated");
      }
      DocumentReference userDoc =
          firebaseFirestore.collection("users").doc(user.uid);

      if (image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = firebaseStorage
            .ref('user')
            .child(user.uid)
            .child('profile_picture')
            .child('$fileName.png');

        UploadTask uploadTask = ref.putFile(image);
        TaskSnapshot taskSnapshot = await uploadTask;

        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        userDoc.update({
          "fullName": fullName,
          "profilePicture": downloadUrl,
          "updatedAt": DateTime.now().toString(),
        });
      } else {
        userDoc.update({
          "fullName": fullName,
          "updatedAt": DateTime.now().toString(),
        });
      }
    } catch (e) {
      log("Error on editProfile: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Recommendation>> getRecommendation(
      {required bool isSportRecommendation}) async {
    try {
      List<Recommendation> recommendationList = [];
      if (isSportRecommendation) {
        final uid = firebaseAuth.currentUser!.uid;
        if (isSportRecommendation) {
          CollectionReference ref = firebaseFirestore
              .collection('users')
              .doc(uid)
              .collection('sport_recommendation');

          final data = await ref.get();

          for (var doc in data.docs) {
            Recommendation recommendation =
                Recommendation.fromMap(doc.data() as Map<String, dynamic>);
            recommendationList.add(recommendation);
          }
        }
        log('Sport Recommendation List: $recommendationList');
      }
      return recommendationList;
    } catch (e) {
      log('Error on getRecommendation: $e');
      throw ServerException(e.toString());
    }
  }
}
