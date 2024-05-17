import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/features/assesment/data/datasource/assesment_remote_datasource.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';

class AssesmentRepositoryImpl implements AssesmentRepository {
  final AssesmentRemoteDataSource assesmentRemoteDataSource;

  AssesmentRepositoryImpl(this.assesmentRemoteDataSource);

  @override
  Future<Either<Failure, void>> saveUserAssesmentData({
    required String fullName,
    required String dateOfBirth,
    required int gender,
    required int weight,
    required int height,
    required String userId,
    required int activityStatus,
    required int healthPurpose,
  }) async {
    try {
      await assesmentRemoteDataSource.saveUserAssesmentData(
        fullName: fullName,
        dateOfBirth: dateOfBirth,
        gender: gender,
        weight: weight,
        height: height,
        userId: userId,
        activityStatus: activityStatus,
        healthPurpose: healthPurpose,
      );

      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
