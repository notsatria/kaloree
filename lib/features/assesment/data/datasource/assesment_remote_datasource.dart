import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> updateLatestAssesmentData({
    required int weight,
    required int height,
    required int activityStatus,
    required int healthPurpose,
  });
}

class AssesmentRemoteDataSourceImpl implements AssesmentRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth fireabaseAuth;

  AssesmentRemoteDataSourceImpl(this.firebaseFirestore, this.fireabaseAuth);

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
      final user = fireabaseAuth.currentUser;
      DocumentReference userDoc =
          firebaseFirestore.collection("users").doc(user!.uid);

      final healthProfile = HealthProfile(
        uid: const Uuid().v1(),
        gender: gender,
        dateOfBirth: dateOfBirth,
        height: height,
        weight: weight,
        userId: user.uid,
        activityStatus: activityStatus,
        healthPurpose: healthPurpose,
        updatedAt: DateTime.now().toString(),
      );

      await userDoc
          .collection("health_profile")
          .doc()
          .set(healthProfile.toMap());
      await userDoc.update({
        'fullName': fullName,
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateGender({required int gender}) async {
    final user = fireabaseAuth.currentUser;
    CollectionReference healtProfileCollection = firebaseFirestore
        .collection("users")
        .doc(user!.uid)
        .collection("health_profile");
  }

  @override
  Future<void> updateLatestAssesmentData(
      {required int weight,
      required int height,
      required int activityStatus,
      required int healthPurpose}) {
    // TODO: implement updateLatestAssesmentData
    throw UnimplementedError();
  }
}
