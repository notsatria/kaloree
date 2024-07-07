import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/core/model/health_profile.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/features/home/data/model/recommendation.dart';

abstract interface class HomeRemoteDataSource {
  Future<UserModel> getUserData();

  Future<double> getDailyCaloriesSupplied();

  Future<void> saveRecommendation(
      {required bool isSportRecommendation, required String result});
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

  @override
  Future<double> getDailyCaloriesSupplied() async {
    try {
      final uid = firebaseAuth.currentUser!.uid;

      CollectionReference classificationCollection = firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('classification_result');

      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      DocumentSnapshot snapshot =
          await classificationCollection.doc(today).get();

      double dailyCaloriesSupplied = 0;

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        log('$data');
        if (data != null && data['classification_result_list'] != null) {
          List classificationResultList = data['classification_result_list'];
          for (var item in classificationResultList) {
            ClassificationResult classificationResult =
                ClassificationResult.fromMap(item as Map<String, dynamic>);
            dailyCaloriesSupplied += classificationResult.food.calories;
          }
        }
      }
      debugPrint("dailyCaloriesSupplied: $dailyCaloriesSupplied");
      return dailyCaloriesSupplied;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> saveRecommendation(
      {required bool isSportRecommendation, required String result}) async {
    try {
      final uid = firebaseAuth.currentUser!.uid;
      if (isSportRecommendation) {
        CollectionReference collection = firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection('sport_recommendation');

        final createdAt = DateTime.now().toString();
        final recommendation = Recommendation(
            id: 'sport$createdAt', result: result, createdAt: createdAt);

        collection.doc().set(recommendation.toMap());
      } else {
        CollectionReference collection = firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection('food_recommendation');

        final createdAt = DateTime.now().toString();
        final recommendation = Recommendation(
            id: 'food$createdAt', result: result, createdAt: createdAt);

        collection.doc().set(recommendation.toMap());
      }
    } catch (e) {
      log('Error on saveRecommendation: $e');
      throw ServerException(e.toString());
    }
  }
}
