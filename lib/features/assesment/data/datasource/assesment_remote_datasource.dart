import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/health_profile.dart';
import 'package:uuid/uuid.dart';

abstract interface class AssesmentRemoteDataSource {
  Future<void> saveUserAssesmentData({
    required String fullName,
    required String dateOfBirth,
    required int gender,
    required int weight,
    required int height,
    required int activityStatus,
    required int healthPurpose,
  });

  Future<void> updateGender({required int gender});

  Future<void> updateLastAssesmentData({
    required int weight,
    required int height,
    required int activityStatus,
    required int healthPurpose,
  });
}

class AssesmentRemoteDataSourceImpl implements AssesmentRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  AssesmentRemoteDataSourceImpl(this.firebaseFirestore, this.firebaseAuth);

  @override
  Future<void> saveUserAssesmentData({
    required String fullName,
    required String dateOfBirth,
    required int gender,
    required int weight,
    required int height,
    required int activityStatus,
    required int healthPurpose,
  }) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw ServerException("User not authenticated");
      }
      DocumentReference userDoc =
          firebaseFirestore.collection("users").doc(user.uid);
      DocumentReference healthProfileDoc =
          userDoc.collection("health_profile").doc(user.uid);

      await firebaseFirestore.runTransaction((transaction) async {
        // Check if the health profile document already exists
        DocumentSnapshot healthProfileSnapshot =
            await transaction.get(healthProfileDoc);
        if (healthProfileSnapshot.exists) {
          throw ServerException("Health profile already exists");
        }

        DateTime dob = DateFormat("yyyy-MM-dd").parse(dateOfBirth);
        int age = _calculateAge(dob);

        debugPrint("Age: $age");

        final healthProfile = HealthProfile(
          uid: const Uuid().v1(),
          gender: gender,
          dateOfBirth: dateOfBirth,
          height: height,
          weight: weight,
          age: age,
          userId: user.uid,
          activityStatus: activityStatus,
          healthPurpose: healthPurpose,
          updatedAt: DateTime.now().toString(),
        );

        transaction.set(healthProfileDoc, healthProfile.toMap());

        transaction.update(userDoc, {
          'fullName': fullName,
        });
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  int _calculateAge(DateTime dateOfBirth) {
    DateTime today = DateTime.now();
    int age = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  @override
  Future<void> updateGender({required int gender}) async {
    try {
      final user = firebaseAuth.currentUser;
      CollectionReference healtProfileCollection = firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection("health_profile");

      await healtProfileCollection.doc(user.uid).update({
        'gender': gender,
      });
    } catch (e) {
      ServerException(e.toString());
    }
  }

  @override
  Future<void> updateLastAssesmentData({
    required int weight,
    required int height,
    required int activityStatus,
    required int healthPurpose,
  }) async {
    try {
      final user = firebaseAuth.currentUser;
      CollectionReference healtProfileCollection = firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection("health_profile");

      await healtProfileCollection.doc(user.uid).update({
        'weight': weight,
        'height': height,
        'activityStatus': activityStatus,
        'healthPurpose': activityStatus,
      });
    } catch (e) {
      ServerException(e.toString());
    }
  }
}
