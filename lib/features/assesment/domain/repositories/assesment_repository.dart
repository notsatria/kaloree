import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';

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
}
