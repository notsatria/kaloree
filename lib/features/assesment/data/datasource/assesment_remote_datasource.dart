import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaloree/core/model/health_profile.dart';
import 'package:uuid/uuid.dart';

abstract interface class AssesmentRemoteDataSource {
  Future<void> saveUserAssesmentData({
    required String fullName,
    required String dateOfBirth,
    required int gender,
    required int weight,
    required int height,
    required String userId,
    required int activityStatus,
    required int healthPurpose,
  });
}

class AssesmentRemoteDataSourceImpl implements AssesmentRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  AssesmentRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<void> saveUserAssesmentData({
    required String fullName,
    required String dateOfBirth,
    required int gender,
    required int weight,
    required int height,
    required String userId,
    required int activityStatus,
    required int healthPurpose,
  }) async {
    DocumentReference userDoc =
        firebaseFirestore.collection("users").doc(userId);

    final healthProfile = HealthProfile(
      uid: const Uuid().v1(),
      gender: gender,
      dateOfBirth: dateOfBirth,
      height: height,
      weight: weight,
      userId: userId,
      activityStatus: activityStatus,
      healthPurpose: healthPurpose,
      updatedAt: DateTime.now().toString(),
    );

    userDoc.collection("health_profile").add(healthProfile.toMap());
  }
}
