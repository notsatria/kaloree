import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';

class UserSaveAssesment implements UseCase<void, UserSaveAssesmentParams> {
  final AssesmentRepository repository;

  UserSaveAssesment(this.repository);
  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.saveUserAssesmentData(
      fullName: params.fullName,
      dateOfBirth: params.dateOfBirth,
      gender: params.gender,
      weight: params.weight,
      height: params.height,
      userId: params.userId,
      activityStatus: params.activityStatus,
      healthPurpose: params.healthPurpose,
    );
  }
}

class UserSaveAssesmentParams {
  final String fullName;
  final String dateOfBirth;
  final int gender;
  final int weight;
  final int height;
  final String userId;
  final int activityStatus;
  final int healthPurpose;

  UserSaveAssesmentParams({
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.weight,
    required this.height,
    required this.userId,
    required this.activityStatus,
    required this.healthPurpose,
  });
}
