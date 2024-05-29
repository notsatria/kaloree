import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/health_profile.dart';

abstract interface class AssesmentRepository {
  Future<Either<Failure, void>> saveUserAssesmentData({
    required String fullName,
    required String dateOfBirth,
    required int gender,
    required int weight,
    required int height,
    required int activityStatus,
    required int healthPurpose,
  });

  Future<Either<Failure, void>> updateGender({required int gender});

  Future<Either<Failure, void>> updateLastAssesmentData({
    required int weight,
    required int height,
    required int activityStatus,
    required int healthPurpose,
  });

  Future<Either<Failure, HealthProfile>> getUserHealthProfile();
}
