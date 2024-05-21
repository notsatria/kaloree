import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';

class UserUpdateLastAssesment
    implements UseCase<void, UserUpdateLastAssesmentParams> {
  final AssesmentRepository repository;

  UserUpdateLastAssesment(this.repository);

  @override
  Future<Either<Failure, void>> call(
      UserUpdateLastAssesmentParams params) async {
    return await repository.updateLastAssesmentData(
      weight: params.weight,
      height: params.height,
      activityStatus: params.activityStatus,
      healthPurpose: params.healthPurpose,
    );
  }
}

class UserUpdateLastAssesmentParams {
  final int weight;
  final int height;
  final int activityStatus;
  final int healthPurpose;

  UserUpdateLastAssesmentParams({
    required this.weight,
    required this.height,
    required this.activityStatus,
    required this.healthPurpose,
  });
}
