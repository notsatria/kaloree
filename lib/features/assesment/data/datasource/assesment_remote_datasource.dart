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

        if (healthProfileSnapshot.exists) {
          transaction.update(healthProfileDoc, {
            'age': age,
            'dateOfBirth': dateOfBirth,
            'updatedAt': DateTime.now().toString(),
          });
        }
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
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
      DocumentReference healthProfileDoc = firebaseFirestore
          .collection("users")
          .doc(user!.uid)
          .collection("health_profile")
          .doc(user.uid);

      DocumentReference userDoc =
          firebaseFirestore.collection("users").doc(user.uid);

      // Retrieve the existing health profile
      DocumentSnapshot healthProfileSnapshot = await healthProfileDoc.get();

      if (!healthProfileSnapshot.exists) {
        throw ServerException("Health profile does not exist");
      }

      // Get the existing data
      Map<String, dynamic> existingData =
          healthProfileSnapshot.data() as Map<String, dynamic>;

      int activityStatus = existingData['activityStatus'];
      int age = existingData['age'];
      int gender = existingData['gender'];

      await healthProfileDoc.update({
        'weight': weight,
        'height': height,
        'activityStatus': activityStatus,
        'healthPurpose': activityStatus,
        'bmiIndex': _calculateBMIIndex(weight: weight, height: height),
        'bmr': _calculateBMR(
          gender: gender,
          activityStatus: activityStatus,
          weight: weight,
          height: height,
          age: age,
        )
      });

      await userDoc.update({
        'isAssesmentComplete': true,
      });
    } catch (e) {
      ServerException(e.toString());
    }
  }

  double _calculateBMIIndex({required int weight, required int height}) {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  double _calculateBMR({
    required int gender,
    required int activityStatus,
    required int weight,
    required int height,
    required int age,
  }) {
    double bmr = 0.0;
    double activityLevel = 1.2;
    if (gender == 0) {
      bmr = 66 + (13.7 * weight) + (5 * height) - (6.78 * age);
    } else {
      bmr = 655 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
    }

    switch (activityStatus) {
      case 0:
        activityLevel = 1.2;
        break;
      case 1:
        activityLevel = 1.375;
        break;
      case 2:
        activityLevel = 1.55;
        break;
      case 3:
        activityLevel = 1.725;
        break;
      case 4:
        activityLevel = 1.9;
        break;
      default:
        activityLevel = 1.2;
    }

    return bmr * activityLevel;
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
}
